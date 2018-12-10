require_relative 'dialog_message'
require_relative 'dialog_conversation'
require_relative '../request/models/response'
module Sapcai
  class DialogResponse
    attr_reader :messages, :conversation, :nlp, :logs

    def initialize(messages, conversation, nlp, logs)
      raise Sapcai::SapcaiError("Invalid messages format: #{messages}") unless messages.is_a?(Array)

      @messages = messages.map{ |m| Sapcai::DialogMessage.new(m) }
      @conversation = DialogConversation.new(conversation)
      @nlp = Response.new('results' => nlp)
      @logs = logs
    end
  end
end
