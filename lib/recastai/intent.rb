# encoding: utf-8

##
# This class builds an intent from RecastAI::Request and RecastAI::Conversation
module RecastAI
  class Intent
    attr_reader :slug
    attr_reader :confidence

    def initialize(intent)
      @slug       = intent['slug']
      @confidence = intent['confidence']
    end
  end
end
