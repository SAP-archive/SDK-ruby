# encoding: utf-8

require_relative '../utils'

module RecastAI
  class Expression
    attr_reader :id, :source, :tokens, :language

    def initialize(response)
      @raw = response

      @id = response['id']
      @source = response['source']
      @tokens = response['tokens']
      @language = response['language']
    end
  end
end
