# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'battle_ship/version'

Gem::Specification.new do |spec|
  spec.name          = "battle_ship"
  spec.version       = BattleShip::VERSION
  spec.authors       = ["DavidRagone"]
  spec.email         = ["dmragone@gmail.com"]
  spec.description   = %q{Wrapper class for Rails.cache related methods to track cache hits & misses}
  spec.summary       = %q{Wrapper for Rails.cache methods}
  spec.homepage      = "http://www.dmragone.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
