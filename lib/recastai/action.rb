# encoding: utf-8

##
# This class builds an action used by RecastAI:::Conversation
module RecastAI
  class Action
    attr_reader :slug
    attr_reader :done
    attr_reader :reply

    def initialize(action)
      @slug  = action['slug']
      @done  = action['done']
      @reply = action['reply']
    end
  end
end
