# encoding: utf-8

dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require 'date'
require 'lib/sapcai/utils'

Gem::Specification.new do |spec|
  spec.name                  = 'Sapcai'
  spec.version               = Sapcai::Utils::VERSION
  spec.date                  = Date.today
  spec.summary               = 'SAP Conversational AI official SDK for Ruby'
  spec.description           = 'SAP Conversational AI official SDK for Ruby. Allows you to make requests to your bots.'
  spec.homepage              = 'https://github.com/SAPConversationalAI/SDK-ruby'
  spec.license               = 'MIT'
  spec.authors               = ['SAP CAI team']
  spec.files                 = `git ls-files -z`.split("\x0").reject{ |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables           = ['sapcaicli']
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 2.2'

  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'httmultiparty', '~> 0.3'

  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'webmock', '~> 1.24'
  spec.add_development_dependency 'awesome_print', '~> 1.6'
  spec.add_development_dependency 'simplecov', '~> 0.15'
end
