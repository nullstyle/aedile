# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aedile/version'

Gem::Specification.new do |spec|
  spec.name          = "aedile"
  spec.version       = Aedile::VERSION
  spec.authors       = ["Scott Fleckenstein"]
  spec.email         = ["nullstyle@gmail.com"]
  spec.description   = %q{Higher level orchestration on top of fleet}
  spec.summary       = %q{Higher level orchestration on top of fleet}
  spec.homepage      = "https://github.com/nullstyle/aedile"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"

  spec.add_dependency "activesupport", ">= 4.0"
  spec.add_dependency "thor",          "~> 0.18.1"
  spec.add_dependency "hirb",          "~> 0.7.1"
  spec.add_dependency "etcd",          "~> 0.2.3"
end
