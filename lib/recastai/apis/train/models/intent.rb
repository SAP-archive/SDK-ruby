# encoding: utf-8

require_relative '../utils'
require_relative 'expression'
require 'json'

module RecastAI
  class Intent
    attr_accessor :id, :name, :slug, :description, :expressions

    def initialize(response = nil, token = nil, user_name = nil, bot_name = nil)
      @token = token
      @user_name = user_name
      @bot_name = bot_name

      @raw = response

      if response
        @id = response['id']
        @name = response['name']
        @slug = response['slug']
        @description = response['description']
        @expressions = (response['expressions'] || []).map {|i| Expression.new i }
      end
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

    def as_json(options = {})
      data = {
        name: name,
        slug: slug,
        description: description,
        expressions: expressions.map {|e| e.as_json}
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end
  end
end
