require_relative 'dialog_message'
require_relative 'dialog_conversation'
require_relative '../request/models/response'
module RecastAI
  class DialogResponse
    attr_reader :messages, :conversation, :nlp

    def initialize(messages, conversation, nlp)
      raise RecastAI::RecastError("Invalid messages format: #{messages}") unless messages.is_a?(Array)

      @messages = messages.map{ |m| RecastAI::DialogMessage.new(m) }
      @conversation = DialogConversation.new(conversation)
      @nlp = Response.new('results' => nlp)
    end
  end
end
