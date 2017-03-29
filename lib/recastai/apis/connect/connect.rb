# encoding: utf-8

require_relative 'message'

module RecastAI
  class Connect
    include Message

    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      @token = token
      @language = language
    end
  end
end
