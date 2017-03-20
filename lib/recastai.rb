# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'httparty'
require 'httmultiparty'
require 'json'

require 'recastai/apis/connect/connect'
require 'recastai/apis/host/host'
require 'recastai/apis/monitor/monitor'
require 'recastai/apis/request/request'
require 'recastai/apis/train/train'

module RecastAI
  class Client
    attr_reader :token, :language, :proxy

    def initialize(token=nil, language=nil, proxy=nil)
      [RecastAI::Request].each do |api|
        name = api.name.split('::').last.downcase # FIXME, weak demodulize
        self.class.send(:define_method, name.to_sym, lambda { api.new(token, language, proxy) })
      end
    end
  end
end
