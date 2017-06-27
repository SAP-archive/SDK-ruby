# encoding: utf-8

require_relative '../utils'
require_relative 'intent'

module RecastAI
  class Bot
    attr_reader :id, :name, :slug, :description, :public, :strictness,
      :request_token, :developer_token, :children_count, :parent, :intents,
      :actions, :gazettes, :language
    attr_accessor :user_name

    def initialize(response, token)
      @token = token

      @raw = response

      response = JSON.parse(response)
      response = response['results']

      @id = response['id']
      @name = response['name']
      @slug = response['slug']
      @description = response['description']
      @public = response['public']
      @strictness = response['strictness']
      @request_token = response['request_token']
      @developer_token = response['developer_token']
      @children_count = response['children_count']
      @parent = response['parent']
      @intents = response['intents'].map {|i| Intent.new(i, self) }
      @actions = response['actions']
      @gazettes = response['gazettes']
      @language = response['language']

      @user_name = response['user']['nickname']
    end

    def find_intent_by_slug(slug)
      response = HTTParty.get(
        Utils::endpoint(@user_name, @name, Utils::INTENTS_SUFFIX, slug),
        headers: { 'Authorization' => "Token #{@token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      body = JSON.parse(response.body)
      Intent.new(body['results'], self)
    end

    def create_intent(intent)
      response = HTTParty.post(
        Utils::endpoint(@user_name, @name, Utils::INTENTS_SUFFIX),
        headers: {
          'Authorization': "Token #{@token}",
          'Content-Type': 'application/json'
        },
        body: intent.to_json
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 201
    end
  end
end
