# -*- encoding: utf-8 -*-

$:.unshift File.expand_path("../lib", __FILE__)
require "synapse_api_client/version"


Gem::Specification.new do |s|
  s.authors       = ["Adam Saegebarth"]
  s.email         = ["adams@synapse.com"]
  s.description   = %q{Client to consume Synapse REST API}
  s.summary       = s.description
  s.homepage      = ""

  s.add_dependency 'rake'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'hashie'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.name          = "synapse_api_client"
  s.require_paths = ["lib"]
  s.version       = SynapseApiClient::VERSION
end
