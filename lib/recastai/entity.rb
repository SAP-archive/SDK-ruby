# encoding: utf-8

##
# This class build an Entity used in RecastAI::Response and RecastAI::Conversation
module RecastAI
  class Entity
    attr_reader :name

    def initialize(name, data)
      @name = name

      # For each pair key, value, set a instance variable
      # and an attr_reader named k and returning v
      data.each_pair do |k, v|
        self.instance_variable_set("@#{k}", v)
        self.define_singleton_method(k.to_sym){ v }
      end
    end
  end
end
