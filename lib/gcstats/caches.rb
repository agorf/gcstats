require 'rexml/document'
require 'date'
require 'time'

module GCStats
  module Caches
    NS = 'groundspeak'

    def self.from_xml(xml_data)
      caches = []
      doc = REXML::Document.new(xml_data)
      doc.each_element('/gpx/wpt') {|wpt_node|
        caches << Cache.new(wpt_node)
      }
      caches
    end

    class Cache
      def initialize(wpt_node)
        @wpt_node = wpt_node
        @cache_node = wpt_node.elements["#{NS}:cache"]
      end

      def lat
        @lat ||= @wpt_node.attributes['lat'].to_f
      end

      alias :latitude :lat

      def lon
        @lon ||= @wpt_node.attributes['lon'].to_f
      end

      alias :longitude :lon

      def published
        @published ||= Time.parse(@wpt_node.elements['time'].text)
      end

      alias :time :published

      def code
        @code ||= @wpt_node.elements['name'].text
      end

      def url
        @url ||= @wpt_node.elements['url'].text
      end

      def available?
        @available ||= @cache_node.attributes['available'].to_s.downcase == 'true'
      end

      def archived?
        @archived ||= @cache_node.attributes['archived'].to_s.downcase == 'true'
      end

      def name
        @name ||= @cache_node.elements["#{NS}:name"].text
      end

      def owner
        @owner ||= @cache_node.elements["#{NS}:owner"].text
      end

      def placed_by
        @placed_by ||= @cache_node.elements["#{NS}:placed_by"].text
      end

      def type
        @type ||= @cache_node.elements["#{NS}:type"].text
      end

      def container
        @container ||= @cache_node.elements["#{NS}:container"].text
      end

      alias :size :container

      def difficulty
        @difficulty ||= @cache_node.elements["#{NS}:difficulty"].text.to_f
      end

      def terrain
        @terrain ||= @cache_node.elements["#{NS}:terrain"].text.to_f
      end

      def country
        @country ||= @cache_node.elements["#{NS}:country"].text
      end

      def state
        @state ||= @cache_node.elements["#{NS}:state"].text.strip
      end

      def logs
        @logs ||= begin
          logs = []

          @cache_node.each_element("#{NS}:logs/#{NS}:log") {|log_node|
            logs << Log.new(log_node)
          }

          logs
        end
      end

      def find_dates
        @find_dates ||= begin
          logs.select {|log| log.found? }.map {|log| log.date }
        end
      end
    end

    class Log
      def initialize(log_node)
        @log_node = log_node
      end

      def id
        @id ||= @log_node.attributes['id'].to_i
      end

      def date
        @date ||= Date.parse(@log_node.elements["#{NS}:date"].text)
      end

      def type
        @type ||= @log_node.elements["#{NS}:type"].text
      end

      def finder
        @finder ||= @log_node.elements["#{NS}:finder"].text
      end

      def found?
        ['found it', 'attended'].include?(self.type.downcase)
      end
    end
  end
end
