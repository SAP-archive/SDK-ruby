module RecastAI
  class Response
    attr_reader :raw
    attr_reader :source
    attr_reader :intents
    attr_reader :sentences
    attr_reader :version
    attr_reader :timestamp
    attr_reader :status

    def initialize(response)
      @raw = response

      response = JSON.parse(response)
      response = response['results']

      @source    = response['source']
      @intents   = response['intents']
      @sentences = response['sentences'].map{ |s| Sentence.new(s) }
      @version   = response['version']
      @timestamp = response['timestamp']
      @status    = response['status']
    end

    ##
    # Returns the first intent provided there is one
    #
    # * *Args* :
    # * *Returns* :
    #   - A String or nil
    def intent
      @intents.any? ? @intents.first : nil
    end

    ##
    # Returns the first sentence provided there is one
    #
    # * *Args* :
    # * *Returns* :
    #   - A Sentence or nil
    def sentence
      @sentences.any? ? @sentences.first : nil
    end

    ##
    # Returns the first entity whose name matches the parameter
    #
    # * *Args* :
    #   - +name+ - String, the entity's name
    # * *Returns* :
    #   - An instance of Entity or nil
    def get(name)
      @sentences.each do |sentence|
        sentence.entities.each do |entity|
          return entity if entity.name.casecmp(name.to_s) == 0
        end
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

      @sentences.each do |sentence|
        sentence.entities.each do |entity|
          entities << entity if entity.name.casecmp(name.to_s) == 0
        end
      end

      entities
    end

    ##
    # Returns all entities
    #
    # * *Returns* :
    #   - An array of instances of Entity or an empty array
    def entities
      entities = []

      @sentences.each do |sentence|
        sentence.entities.each do |entity|
          entities << entity
        end
      end

      entities
    end
  end
end
