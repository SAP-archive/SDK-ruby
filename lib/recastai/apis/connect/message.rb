# encoding: utf-8

require_relative 'models/message'
require_relative 'utils'

module RecastAI
  module Message
    def handle_message(request, &block)
      request.body.rewind if request.body.respond_to?(:rewind)
      body = request.body.is_a?(String) ? request.body : request.body.read
      message = Msg.new(body)

      yield(message)
    end

    def send_message(payload, conversation_id, token: nil)
      token ||= @token
      raise RecastError.new('Token is missing') if token.nil?

      response = HTTParty.post(
        "#{Utils::CONVERSATION_ENDPOINT}#{conversation_id}/messages",
        body: { messages: payload.to_json },
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 201

      response
    end

    def broadcast_message(payload, token: nil)
      token ||= @token
      raise RecastError.new('Token is missing') if token.nil?

      response = HTTParty.post(
        Utils::MESSAGE_ENDPOINT,
        body: { messages: payload.to_json },
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 201

      response
    end
  end
end
