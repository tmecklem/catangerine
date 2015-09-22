# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'catangerine/version'

Gem::Specification.new do |spec|
  spec.name          = "catangerine"
  spec.version       = Catangerine::VERSION
  spec.authors       = ["Tim Mecklem"]
  spec.email         = ["timothy@mecklem.com"]
  spec.summary       = %q{Ruby Catan Engine.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "cucumber", "~> 2.1"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "pry-byebug", "~> 3.2"
  spec.add_development_dependency "cairo", "~>1.14"
end
