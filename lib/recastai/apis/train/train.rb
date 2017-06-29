# encoding: utf-8

require_relative 'bot_crud'

module RecastAI
  class Train
    include BotCRUD

    attr_reader :token

    def initialize(token = nil, user_name = nil, bot_name = nil)
      @token = token
      @user_name = user_name
      @bot_name = bot_name
    end
  end
end
