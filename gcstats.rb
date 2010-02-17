#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip'
require 'lib/mapping'
require 'lib/template'

in_fn, out_fn = ARGV[0..1]

if in_fn.nil?
  $stderr.puts "usage: #$0 <infile> [outfile]"
  exit 1
end

if File.extname(in_fn) == '.zip'
  data = nil

  Zip::ZipFile.foreach(in_fn) {|entry|
    if File.extname(entry.name) == '.gpx'
      data = entry.get_input_stream.read
      out_fn ||= File.basename(entry.name, '.gpx') + '.html'
      break
    end
  }
else
  data = File.read(in_fn)
  out_fn ||= File.basename(in_fn, File.extname(in_fn)) + '.html'
end

wpts = Waypoint.parse(data)
caches = wpts.map {|w| w.cache }

rhtml = open('stats.rhtml').read
t = Template.new(rhtml, :wpts => wpts, :caches => caches)
open(out_fn, 'w') {|f| f.write(t.result) }
puts "wrote #{out_fn}"  if test(?s, out_fn)
