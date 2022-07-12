# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'behavioral/version'

Gem::Specification.new do |spec|
  spec.name          = "behavioral"
  spec.version       = Behavioral::VERSION
  spec.authors       = ["'Jim Gay'"]
  spec.email         = ["jim@saturnflyer.com"]
  spec.summary       = %q{Add and remove behaviors to individual objects}
  spec.description   = %q{Add and remove behaviors to individual objects}
  spec.homepage      = "http://github.com/saturnflyer/behavioral"
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*", File::FNM_DOTMATCH) + %w[ README.md LICENSE.txt behavioral.gemspec Gemfile ]
  spec.test_files    = Dir.glob("test/**/*", File::FNM_DOTMATCH)
  spec.require_paths = ["lib"]
end
