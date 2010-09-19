Gem::Specification.new do |s|
  s.name        = 'gcstats'
  s.version     = '1.0.0'
  s.summary     = 'Simple and clean statistics of your Geocaching activity'
  s.description = 'Simple and clean statistics of your Geocaching activity'

  s.author      = 'Aggelos Orfanakos'
  s.email       = 'agorf@agorf.gr'
  s.homepage    = 'http://github.com/agorf/gcstats'

  s.files       = Dir['README.md', 'config.ru', 'bin/gcstats', 'lib/**/*']
  s.executables = ['gcstats']

  s.add_dependency 'rubyzip'
end