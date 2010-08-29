require 'erb'
require 'gcstats/helpers'

module GCStats
  class Template
    include Helpers

    def initialize(text, data)
      @text = text
      data.each {|n, v| instance_variable_set("@#{n}", v) }
    end

    def result
      ERB.new(@text).result(binding)
    end

    alias :to_s :result
  end
end
