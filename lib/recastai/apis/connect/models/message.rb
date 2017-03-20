
require_relative '../utils'
require_relative '../../errors'

module RecastAI
  class Msg
    attr_reader :token, :content, :type, :conversation_id, :replies

    def initialize(request, token)
      @token = token

      request = JSON.parse(request)
      request.each do |k, v|
        self.instance_variable_set("@#{k}", v)
        self.define_singleton_method(k.to_sym){ v }
      end

      @content = request['message']['attachement']['content']
      @type = request['message']['attachement']['type']
      @conversation_id = request['message']['conversation_id']

      @replies = []
    end

    def add_replies(replies)
      replies = [replies] unless replies.is_a?(Array)
      @replies.concat(replies)
    end

    def reply(replies=[])
      replies = [replies] unless replies.is_a?(Array)

      response = HTTParty.post(
        Utils::CONVERSATION_ENDPOINT + conversation_id + '/messages',
        json: {'message': @replies + replies},
        headers: { 'Authorization' => "Token #{token}" }
      )

      raise(RecastError.new(response.message)) if response.code != 200

      response
    end
  end
end
