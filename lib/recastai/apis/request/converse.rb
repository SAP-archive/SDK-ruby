
require_relative '../errors'
require_relative 'utils'
require_relative 'models/conversation'

module RecastAI
  module Converse
    def converse_text(text, token = nil, language = nil, proxy = nil, conversation_token = nil, memory = nil)
      token ||= @token
      raise(RecastError.new('Token is missing')) if token.nil?

      language ||= @language

      body = { text: text }
      body[:language] = language unless language.nil?
      body[:conversation_token] = conversation_token unless conversation_token.nil?
      body[:memory] = memory unless memory.nil?

      response = HTTParty.post(
        Utils::CONVERSE_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )

      raise(RecastError.new(response.message)) if response.code != 200

      Conversation.new(response.body)
    end
  end
end
