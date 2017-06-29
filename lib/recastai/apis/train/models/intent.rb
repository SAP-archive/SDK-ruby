# encoding: utf-8

require_relative '../utils'
require_relative 'expression'
require 'json'

module RecastAI
  class Intent
    attr_accessor :id, :name, :slug, :description, :expressions
    attr_accessor :bot

    def initialize(response = nil, bot = nil)
      @bot = bot

      @raw = response

      if response
        @id = response['id']
        @name = response['name']
        @slug = response['slug']
        @description = response['description']
        @expressions = (response['expressions'] || []).map {|e| Expression.new e, self }
      end
    end

    def find_expression_by_id(id)
      response = HTTParty.get(
        Utils::endpoint(@bot.user_slug, bot.name, Utils::INTENTS_SUFFIX, @slug, Utils::EXPRESSIONS_SUFFIX, id),
        headers: { 'Authorization' => "Token #{@token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      body = JSON.parse(response.body)
      Expression.new(body['results'], self)
    end

    def as_json(options = {})
      data = {
        name: name,
        slug: slug,
        description: description,
        expressions: expressions ? expressions.map {|e| e.as_json} : nil
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end

    def save!
      response = HTTParty.put(
        Utils::endpoint(@bot.user_slug, @bot.slug, Utils::INTENTS_SUFFIX, @slug),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: self.to_json
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200
    end

    def create_expression(expression)
      response = HTTParty.post(
        Utils::endpoint(@bot.user_slug, @bot.name, Utils::INTENTS_SUFFIX, @slug, Utils::EXPRESSIONS_SUFFIX),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: expression.to_json
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 201
    end

    def delete!
      response = HTTParty.delete(
        Utils::endpoint(@bot.user_slug, @bot.name, Utils::INTENTS_SUFFIX, self.slug),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}"
        }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200
    end
  end
end
