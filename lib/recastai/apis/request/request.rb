# encoding: utf-8

require_relative 'analyse'
require_relative 'converse'

module RecastAI
  class Request
    include Converse
    include Analyse

    attr_reader :token, :language, :proxy

    def initialize(token = nil, language = nil, proxy = nil)
      @token = token
      @language = language
      @proxy = proxy
    end
  end
end
