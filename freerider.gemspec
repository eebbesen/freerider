# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freerider/version'

Gem::Specification.new do |spec|
  spec.name          = 'freerider'
  spec.version       = Freerider::VERSION
  spec.authors       = ['Eric Ebbesen']
  spec.email         = ['git.eebbesen@gmail.com']
  spec.summary       = 'Locate local car2go vehicles that need to be fueled.'
  spec.description   = 'car2go offers 20 minutes of free time when you refuel a vehicle that is less than 25 percent fueled. freerider identifies car2go vehicles in your area which you can refuel for free minutes!'
  spec.homepage      = 'https://github.com/eebbesen/freerider'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'caruby2go'
  spec.add_dependency 'geocoder'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  # rspec
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'rspec_junit_formatter', '0.2.2'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
end
