# encoding: utf-8

require_relative '../utils'
require_relative 'expression'

module RecastAI
  class Intent
    attr_reader :id, :name, :slug, :description, :expressions

    def initialize(response, token, user_name, bot_name)
      @token = token
      @user_name = user_name
      @bot_name = bot_name

      @raw = response

      @id = response['id']
      @name = response['name']
      @slug = response['slug']
      @description = response['description']
      @expressions = (response['expressions'] || []).map {|i| Expression.new i }
    end

    def find_expression_by_id(id)
      response = HTTParty.get(
        Utils::endpoint(@user_name, @bot_name, Utils::INTENTS_SUFFIX, @slug, Utils::EXPRESSIONS_SUFFIX, id),
        headers: { 'Authorization' => "Token #{@token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      body = JSON.parse(response.body)
      Expression.new(body['results'])
    end
  end
end
