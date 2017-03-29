# encoding: utf-8

require_relative 'analyse'
require_relative 'converse'

module RecastAI
  class Request
    include Converse
    include Analyse

    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      @token = token
      @language = language
    end
  end
end
