# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openskos/version'

Gem::Specification.new do |spec|
  spec.name          = "openskos"
  spec.version       = OpenSKOS::VERSION
  spec.authors       = ["Richard Doe"]
  spec.email         = ["richard.doe@rwdit.net"]
  spec.summary       = %q{Provides an interface to the OpenSKOS API.}
  spec.description   = %q{A Ruby client for searching and retrieving SKOS concepts from an OpenSKOS instance.}
  spec.homepage      = "https://github.com/europeana/openskos-client-ruby"
  spec.license       = "EUPL 1.1"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 3.0"
  spec.add_dependency "multi_json", "~> 1.0"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "rest-client", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.18.0"
end
