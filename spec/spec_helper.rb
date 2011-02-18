%w{caches helpers template}.each {|f| require "gcstats/#{f}" }

include GCStats

def xml_path
  File.join(*%w{spec fixtures 3627915.gpx})
end

def xml_data
  open(xml_path).read
end

def caches
  Caches.from_xml(xml_data)
end
