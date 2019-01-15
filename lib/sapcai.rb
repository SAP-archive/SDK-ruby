# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'httparty'
require 'httmultiparty'

require 'sapcai/utils'
require 'sapcai/apis/connect/connect'
require 'sapcai/apis/request/request'
require 'sapcai/apis/build/build'

module Sapcai
  class Client
    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      [Sapcai::Request, Sapcai::Connect, Sapcai::Build].each do |api|
        i = api.name.rindex('::')
        name = i.nil? ? api.name : api.name[(i + 2)..-1]

        self.class.send(:define_method, name.downcase.to_sym, ->{ api.new(token, language) })
      end
    end
  end
end
