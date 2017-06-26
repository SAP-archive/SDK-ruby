# encoding: utf-8

require_relative 'bot_crud'

module RecastAI
  class Train
    include BotCRUD

    attr_reader :token, :language

    def initialize(token = nil, language = nil, user_name = nil, bot_name = nil)
      @token = token
      @language = language
      @user_name = user_name
      @bot_name = bot_name
    end
  end
end
