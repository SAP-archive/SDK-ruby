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
  end
end
