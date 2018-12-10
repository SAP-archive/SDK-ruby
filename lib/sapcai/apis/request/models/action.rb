# encoding: utf-8

module Sapcai
  class Action
    attr_reader :slug
    attr_reader :done
    attr_reader :reply

    def initialize(action)
      @slug  = action['slug']
      @done  = action['done']
      @reply = action['reply']
    end

    def done?
      @done
    end
  end
end
