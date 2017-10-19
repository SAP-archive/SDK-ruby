# encoding: utf-8

require 'httparty'

require_relative 'dialog_response'
require_relative 'dialog_message'
require_relative 'dialog_conversation'

module RecastAI
  class Build
    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      @token = token
      @language = language
    end

    def headers
      { 'Authorization' => "Token #{@token}", 'Content-Type' => 'application/json' }
    end

    def dialog(msg, conversation_id, language = nil)
      raise RecastAI::RecastError.new('Token is missing') unless @token

      language = @language if language.nil?
      body = { message: msg, conversation_id: conversation_id, language: language }

      response = HTTParty.post("#{RecastAI::Utils::BUILD_ENDPOINT}/dialog", body: body.to_json, headers: self.headers)
      raise RecastAI::RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      res = JSON.parse(response.body)['results']
      RecastAI::DialogResponse.new(res['messages'], res['conversation'], res['nlp'])
    end

    def update_conversation(user, bot, conversation_id, opts)
      raise RecastAI::RecastError.new('Token is missing') unless @token

      body = opts

      url = "#{RecastAI::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.put(url, body: body.to_json, headers: self.headers)
      raise RecastAI::RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      RecastAI::DialogConversation.new(JSON.parse(response.body)['results'])
    end

    def get_conversation(user, bot, conversation_id)
      raise RecastAI::RecastError.new('Token is missing') unless @token

      url = "#{RecastAI::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.get(url, headers: self.headers)
      raise RecastAI::RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      RecastAI::DialogConversation.new(JSON.parse(response.body)['results'])
    end

    def delete_conversation(user, bot, conversation_id)
      raise RecastAI::RecastError.new('Token is missing') unless @token

      url = "#{RecastAI::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.delete(url, headers: self.headers)
      raise RecastAI::RecastError.new(JSON.parse(response.body)['message']) if response.code != 204

      true
    end
  end
end
