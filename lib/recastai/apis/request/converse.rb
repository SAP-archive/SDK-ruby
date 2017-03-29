# encoding: utf-8

require_relative 'models/conversation'
require_relative 'utils'
require_relative '../errors'

module RecastAI
  module Converse
    def converse_text(text, opts = { token: @token, language: @language, conversation_token: nil, memory: nil })
      raise RecastError.new('Token is missing') if opts[:token].nil?

      body = { text: text }
      body[:language] = opts[:language] unless opts[:language].nil?
      body[:conversation_token] = opts[:conversation_token] unless opts[:conversation_token].nil?
      body[:memory] = opts[:memory] unless opts[:memory].nil?

      response = HTTParty.post(
        Utils::CONVERSE_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{opts[:token]}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      Conversation.new(response.body, opts[:token])
    end
  end
end
