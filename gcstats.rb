#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip'
require 'lib/mapping'
require 'lib/template'

fn = ARGV[0] || Dir.glob('*.zip')[0]

if fn.nil?
  $stderr.puts "usage: #$0 <file>"
  exit 1
end

gpx_fn = File.basename(fn, '.zip') + '.gpx'
data = Zip::ZipFile.open(fn).read(gpx_fn)

wpts = Waypoint.parse(data)
caches = wpts.map {|w| w.cache }

rhtml = open('stats.rhtml').read
t = Template.new(rhtml, :wpts => wpts, :caches => caches)
open('stats.html', 'w') {|f| f.write(t.result) }
