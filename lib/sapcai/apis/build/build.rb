# encoding: utf-8

require 'httparty'

require_relative 'dialog_response'
require_relative 'dialog_message'
require_relative 'dialog_conversation'

module Sapcai
  class Build
    attr_reader :token, :language

    def initialize(token = nil, language = nil)
      @token = token
      @language = language
    end

    def headers
      { 'Authorization' => "Token #{@token}", 'Content-Type' => 'application/json' }
    end

    def dialog(msg, conversation_id, language = nil, options = {})
      raise Sapcai::SapcaiError.new('Token is missing') unless @token

      log_level = options[:log_level] || "info"
      proxy = options[:proxy] || {}

      language = @language if language.nil?
      body = { message: msg, conversation_id: conversation_id, language: language, log_level: log_level}
      body[:memory] = options[:memory] unless options[:memory].nil?

      options = { body: body.to_json, headers: self.headers }
      if proxy != {}
        options[:http_proxyaddr] = proxy[:host]
        options[:http_proxyport] = proxy[:port]
      end
      response = HTTParty.post("#{Sapcai::Utils::BUILD_ENDPOINT}/dialog", options)
      raise Sapcai::SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 200

      res = JSON.parse(response.body)['results']
      Sapcai::DialogResponse.new(res['messages'], res['conversation'], res['nlp'], res['logs'])
    end

    def update_conversation(user, bot, conversation_id, opts)
      raise Sapcai::SapcaiError.new('Token is missing') unless @token

      body = opts

      url = "#{Sapcai::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.put(url, body: body.to_json, headers: self.headers)
      raise Sapcai::SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 200

      Sapcai::DialogConversation.new(JSON.parse(response.body)['results'])
    end

    def get_conversation(user, bot, conversation_id)
      raise Sapcai::SapcaiError.new('Token is missing') unless @token

      url = "#{Sapcai::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.get(url, headers: self.headers)
      raise Sapcai::SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 200

      Sapcai::DialogConversation.new(JSON.parse(response.body)['results'])
    end

    def delete_conversation(user, bot, conversation_id)
      raise Sapcai::SapcaiError.new('Token is missing') unless @token

      url = "#{Sapcai::Utils::BUILD_ENDPOINT}/users/#{user}/bots/#{bot}/builders/v1/conversation_states/#{conversation_id}"
      response = HTTParty.delete(url, headers: self.headers)
      raise Sapcai::SapcaiError.new(JSON.parse(response.body)['message']) if response.code != 204

      true
    end
  end
end
