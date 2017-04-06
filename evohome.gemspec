$:.push File.expand_path("../lib", __FILE__)

require 'evohome/version'

Gem::Specification.new do |s|
  s.name        = 'evohome'
  s.version     = Evohome::VERSION
  s.date        = '2017-04-06'
  s.summary     = "Evohome Client"
  s.description = "Client to interface with Evohome Total Connect Comfort systems"
  s.authors     = ["Rob Aldred"]
  s.email       = 'raldred@gmail.com'
  s.homepage    =
    'http://github.com/raldred/evohome-client'
  s.license       = 'MIT'

  s.add_dependency "faraday", '~> 0.9'
  s.add_dependency "faraday_middleware", '~> 0.9'
  s.add_dependency "addressable", '~> 2.2'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir.glob('spec/*_spec.rb')
end