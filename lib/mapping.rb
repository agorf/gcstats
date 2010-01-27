require 'rubygems'
require 'happymapper'

GEOCACHING_NS = 'http://www.groundspeak.com/cache/1/0'

class Log
  include HappyMapper

  namespace GEOCACHING_NS
  attribute :id, Integer
  element :date, DateTime
  element :type, String
  element :finder, String, :attributes => { :id => Integer }
  element :text, String, :attributes => { :encoded => Boolean }
end

class TravelBug
  include HappyMapper

  namespace GEOCACHING_NS
  attribute :id, Integer
  attribute :ref, String
  element :name, String
end

class Cache
  include HappyMapper

  namespace GEOCACHING_NS
  attribute :id, Integer
  attribute :available, Boolean
  attribute :archived, Boolean
  element :name, String
  element :placed_by, String
  element :owner, String, :attributes => { :id => Integer }
  element :type, String
  element :container, String
  element :difficulty, Float
  element :terrain, Float
  element :country, String
  element :state, String
  element :short_description, String, :attributes => { :html => Boolean }
  element :long_description, String, :attributes => { :html => Boolean }
  element :encoded_hints, String
  has_many :logs, Log
  has_many :travelbugs, TravelBug
end

class Waypoint
  include HappyMapper

  tag 'wpt'
  attribute :lat, Float
  attribute :lon, Float
  element :time, DateTime
  element :name, String
  element :desc, String
  element :url, String
  element :urlname, String
  element :sym, String
  element :type, String
  has_one :cache, Cache
end
