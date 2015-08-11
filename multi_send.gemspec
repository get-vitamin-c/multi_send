# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_send/version'

Gem::Specification.new do |spec|
  spec.name          = "multi_send"
  spec.version       = MultiSend::VERSION
  spec.authors       = ["Matt Parsons"]
  spec.email         = ["parsonsmatt@gmail.com"]

  spec.summary       = %q{MultiSend makes it easy to send a bunch of messages to an object.}
  spec.homepage      = "https://www.github.com/get-vitamin-c/multi_send"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
