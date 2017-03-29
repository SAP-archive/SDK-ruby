# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'httparty'
require 'httmultiparty'

require 'recastai/utils'
require 'recastai/apis/connect/connect'
require 'recastai/apis/request/request'

module RecastAI
  class Client
    attr_reader :token, :language, :proxy

    def initialize(token = nil, language = nil, proxy = nil)
      [RecastAI::Request, RecastAI::Connect].each do |api|
        i = api.name.rindex('::')
        name = i.nil? ? api.name : api.name[(i + 2)..-1]

        self.class.send(:define_method, name.downcase.to_sym, ->{ api.new(token, language, proxy) })
      end
    end
  end
end
