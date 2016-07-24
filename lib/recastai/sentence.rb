# encoding: utf-8

module RecastAI
  class Sentence
    attr_reader :source
    attr_reader :type
    attr_reader :action
    attr_reader :agent
    attr_reader :polarity
    attr_reader :entities

    def initialize(sentence)
      @source   = sentence['source']
      @type     = sentence['type']
      @action   = sentence['action']
      @agent    = sentence['agent']
      @polarity = sentence['polarity']
      @entities = sentence['entities'].flat_map{ |n, e| e.map{ |ee| Entity.new(n, ee) } }
    end

    ##
    # Returns the first entity whose name matches the parameter
    #
    # * *Args* :
    #   - +name+ - String, the entity's name
    # * *Returns* :
    #   - An instance of Entity or nil
    def get(name)
      @entities.each do |entity|
        return entity if entity.name.casecmp(name.to_s) == 0
      end

      nil
    end

    ##
    # Returns all entities whose names matches the parameter
    #
    # * *Args* :
    #   - +name+ - String, the entities' names
    # * *Returns* :
    #   - An array of instances of Entity or an empty array
    def all(name)
      entities = []

      @entities.each do |entity|
        entities << entity if entity.name.casecmp(name.to_s) == 0
      end

      entities
    end
  end
end
