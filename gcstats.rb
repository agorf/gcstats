#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip'
require 'lib/mapping'
require 'lib/template'

fn = ARGV[0]

if fn.nil?
  $stderr.puts "usage: #$0 <file>"
  exit 1
end

if File.extname(fn) == '.zip'
  data = nil

  Zip::ZipFile.foreach(fn) {|entry|
    if File.extname(entry.name) == '.gpx'
      data = entry.get_input_stream.read
      break
    end
  }
else
  data = File.read(fn)
end

wpts = Waypoint.parse(data)
caches = wpts.map {|w| w.cache }

rhtml = open('stats.rhtml').read
t = Template.new(rhtml, :wpts => wpts, :caches => caches)
open('stats.html', 'w') {|f| f.write(t.result) }
