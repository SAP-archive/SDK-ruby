# encoding: utf-8

require_relative 'models/conversation'
require_relative 'utils'
require_relative '../errors'

module Sapcai
  module Converse
    def converse_text(text, token: nil, language: nil, conversation_token: nil, memory: nil)
      token ||= @token
      raise SapcaiError.new('Token is missing') if token.nil?

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
      raise SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 200

      Conversation.new(response.body, token)
    end

    def converse_file(file, token: nil, language: nil, conversation_token: nil, memory: nil)
      token ||= @token
      raise SapcaiError.new('Token is missing') if token.nil?

      language ||= @language

      body = { voice: File.new(file) }
      body[:language] = language unless language.nil?
      body[:conversation_token] = conversation_token unless conversation_token.nil?
      body[:memory] = memory unless memory.nil?
      response = HTTMultiParty.post(
        Utils::CONVERSE_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 200

      Conversation.new(response.body, token)
    end
  end
end
