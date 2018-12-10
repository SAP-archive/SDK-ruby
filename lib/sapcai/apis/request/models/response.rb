# encoding: utf-8

require_relative 'intent'
require_relative 'entity'
require_relative '../utils'

module Sapcai
  class Response
    attr_reader :raw
    attr_reader :uuid
    attr_reader :source
    attr_reader :intents
    attr_reader :act
    attr_reader :type
    attr_reader :sentiment
    attr_reader :entities
    attr_reader :language
    attr_reader :processing_language
    attr_reader :version
    attr_reader :timestamp
    attr_reader :status

    def initialize(response)
      @raw = JSON.dump(response)
      response = response['results']

      @uuid                = response['uuid']
      @source              = response['source']
      @intents             = response['intents'].map{ |i| Intent.new(i) }
      @act                 = response['act']
      @type                = response['type']
      @sentiment           = response['sentiment']
      @entities            = response['entities'].flat_map{ |n, e| e.map{ |ee| Entity.new(n, ee) } }
      @language            = response['language']
      @processing_language = response['processing_language']
      @version             = response['version']
      @timestamp           = response['timestamp']
      @status              = response['status']
    end

    def intent
      @intents.any? ? @intents.first : nil
    end

    def get(name)
      @entities.each do |entity|
        return entity if entity.name.casecmp(name.to_s).zero?
      end

      nil
    end

    def all(name)
      @entities.select do |entity|
        entity.name.casecmp(name.to_s).zero?
      end
    end

    def assert?
      @act == Utils::ACT_ASSERT
    end

    def command?
      @act == Utils::ACT_COMMAND
    end

    def wh_query?
      @act == Utils::ACT_WH_QUERY
    end

    def yn_query?
      @act == Utils::ACT_YN_QUERY
    end

    def abbreviation?
      !@type.index(Utils::TYPE_ABBREVIATION).nil?
    end

    def entity?
      !@type.index(Utils::TYPE_ENTITY).nil?
    end

    def description?
      !@type.index(Utils::TYPE_DESCRIPTION).nil?
    end

    def human?
      !@type.index(Utils::TYPE_HUMAN).nil?
    end

    def location?
      !@type.index(Utils::TYPE_LOCATION).nil?
    end

    def number?
      !@type.index(Utils::TYPE_NUMBER).nil?
    end

    def vpositive?
      @sentiment == Utils::SENTIMENT_VPOSITIVE
    end

    def positive?
      @sentiment == Utils::SENTIMENT_POSITIVE
    end

    def neutral?
      @sentiment == Utils::SENTIMENT_NEUTRAL
    end

    def negative?
      @sentiment == Utils::SENTIMENT_NEGATIVE
    end

    def vnegative?
      @sentiment == Utils::SENTIMENT_VNEGATIVE
    end
  end
end
