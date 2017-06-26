# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'httparty'
require 'httmultiparty'

require 'recastai/utils'
require 'recastai/apis/connect/connect'
require 'recastai/apis/request/request'
require 'recastai/apis/train/train'

module RecastAI
  class Client
    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      [RecastAI::Request, RecastAI::Connect, RecastAI::Train].each do |api|
        i = api.name.rindex('::')
        name = i.nil? ? api.name : api.name[(i + 2)..-1]

        self.class.send(:define_method, name.downcase.to_sym, ->{ api.new(token, language) })
      end
    end
  end
end
