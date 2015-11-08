# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cobi/twitchbot/version'

Gem::Specification.new do |spec|
  spec.name          = "cobi-twitchbot"
  spec.version       = Cobi::Twitchbot::VERSION
  spec.authors       = ["Jacobi Carter"]
  spec.email         = ["cobi@jacobicarter.com"]
  spec.summary       = %q{Cobi's Twitch Bot}
  spec.description   = %q{Basic framework for running a twitch bot}
  spec.homepage      = ""
  spec.license       = "GPL v3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
