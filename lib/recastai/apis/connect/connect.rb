# encoding: utf-8

require_relative 'message'

module RecastAI
  class Connect
    include Message

    attr_reader :token, :language, :proxy

    def initialize(token = nil, language = nil, proxy = nil)
      @token = token
      @language = language
      @proxy = proxy
    end
  end
end
