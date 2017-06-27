# encoding: utf-8

require_relative '../utils'
require_relative 'language'

module RecastAI
  class Expression
    attr_accessor :id, :source, :tokens, :language

    def initialize(response = nil)
      @raw = response

      if response
        @id = response['id']
        @source = response['source']
        @tokens = response['tokens']
        @language = RecastAI::Language.new response['language']
      end
    end

    def as_json(options = {})
      data = {
        source: source,
        language: language.as_json
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end
  end
end
