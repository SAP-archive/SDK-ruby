
require_relative 'utils'
require_relative '../errors'

module RecastAI
  module Message
    def parse_message(request)
      Msg.new(request.body, @token)
    end

    def send_message(payload, conversation_id)
      response = HTTParty.post(
        Utils::CONVERSATION_ENDPOINT + conversation_id + '/messages',
        json: payload,
        headers: { 'Authorization' => "Token #{token}" }
      )

      raise(RecastError.new(response.message)) if response.code != 200

      response
    end

    def broadcast_message(payload)
      response = HTTParty.post(
        Utils::MESSAGE_ENDPOINT,
        json: payload,
        headers: { 'Authorization' => "Token #{token}" }
      )

      raise(RecastError.new(response.message)) if response.code != 200

      response
    end
  end
end
