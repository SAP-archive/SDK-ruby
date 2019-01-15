# encoding: utf-8

module Sapcai
  class Intent
    attr_reader :slug
    attr_reader :confidence

    def initialize(intent)
      @slug       = intent['slug']
      @confidence = intent['confidence']
    end
  end
end
