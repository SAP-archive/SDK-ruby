# encoding: utf-8

module RecastAI
  class Intent
    attr_reader :name
    attr_reader :confidence

    def initialize(intent)
      @name       = intent['name']
      @confidence = intent['confidence']
    end
  end
end
