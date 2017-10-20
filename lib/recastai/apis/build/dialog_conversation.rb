module RecastAI
  class DialogConversation
    attr_reader :id, :language, :memory, :skill, :skill_occurences

    def initialize(conv)
      @id = conv['conversation_id'] || conv['id']
      @language = conv['language']
      @memory = conv['memory']
      @skill = conv['skill'] || conv['last_skill']
      @skill_occurences = conv['skill_occurences'] || skill['last_skill_occurences']
    end
  end
end
