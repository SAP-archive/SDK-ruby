# encoding: utf-8

require_relative 'bot_crud'

module RecastAI
  class Train
    include BotCRUD

    attr_reader :token

    def initialize(token = nil, user_slug = nil, bot_name = nil)
      @token = token
      @user_slug = user_slug
      @bot_name = bot_name
    end
  end
end
