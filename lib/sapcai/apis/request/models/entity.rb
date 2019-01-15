# encoding: utf-8

module Sapcai
  class Entity
    attr_reader :name

    def initialize(name, data)
      @name = name

      data.each_pair do |k, v|
        self.instance_variable_set("@#{k}", v)
        self.define_singleton_method(k.to_sym){ v }
      end
    end
  end
end
