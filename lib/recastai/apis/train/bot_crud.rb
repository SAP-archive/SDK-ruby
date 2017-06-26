# encoding: utf-8

require_relative 'models/bot'
require_relative '../errors'
require_relative 'utils'

module RecastAI
  module BotCRUD
    def bot(token: nil, user_name: nil, bot_name: nil)
      token ||= @token
      raise RecastError.new('Token is missing') if token.nil?

      user_name ||= @user_name
      raise RecastError.new('User name is missing') if user_name.nil?

      bot_name ||= @bot_name
      raise RecastError.new('Bot name is missing') if bot_name.nil?

      ep = Utils::endpoint(user_name, bot_name)

      response = HTTParty.get(
        ep,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      puts response.body

      Bot.new(response.body, token)
    end
  end
end
