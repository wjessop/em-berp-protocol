# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'em-berp-protocol/version'

Gem::Specification.new do |gem|
  gem.name          = "em-berp-protocol"
  gem.version       = EventMachine::Protocols::BerpProtocol::VERSION
  gem.authors       = ["Will Jessop"]
  gem.email         = ["will@willj.net"]
  gem.description   = %q{EventMachine connection protocol for sending and receiving BERP messages}
  gem.summary       = %q{EventMachine connection protocol for sending and receiving BERP messages}
  gem.homepage      = "https://github.com/wjessop/em-berp-protocol"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'bert'
  gem.add_dependency 'eventmachine'
  gem.add_development_dependency 'rake'
end
