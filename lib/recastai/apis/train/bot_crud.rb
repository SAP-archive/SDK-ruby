# encoding: utf-8

require_relative 'models/bot'
require_relative '../errors'
require_relative 'utils'

module RecastAI
  module BotCRUD
    def bot(token: nil, user_slug: nil, bot_name: nil)
      token ||= @token
      raise RecastError.new('Token is missing') if token.nil?

      user_slug ||= @user_slug
      raise RecastError.new('User slug is missing') if user_slug.nil?

      bot_name ||= @bot_name
      raise RecastError.new('Bot name is missing') if bot_name.nil?

      response = HTTParty.get(
        Utils::endpoint(user_slug, bot_name),
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      Bot.new(response.body, user_slug)
    end
  end
end
