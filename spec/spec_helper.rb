%w{caches template}.each {|f| require "gcstats/#{f}" }

include GCStats
