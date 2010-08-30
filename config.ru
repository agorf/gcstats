lib_dir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'gcstats/server'

run Sinatra::Application
