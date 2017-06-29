# encoding: utf-8

require_relative '../utils'
require_relative 'intent'

module RecastAI
  class Bot
    attr_reader :id, :name, :description, :public, :strictness,
      :request_token, :children_count, :parent, :intents,
      :actions, :gazettes, :language, :user_nickname
    attr_accessor :user_slug, :slug, :developer_token

    def initialize(response = nil, user_slug = nil)
      @raw = response

      @user_slug = user_slug

      if response
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
        @user_nickname = response['user']['nickname']
      end
    end

    def find_intent_by_slug(slug)
      response = HTTParty.get(
        Utils::endpoint(@user_slug, @slug, Utils::INTENTS_SUFFIX, slug),
        headers: { 'Authorization' => "Token #{@developer_token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      body = JSON.parse(response.body)
      Intent.new(body['results'], self)
    end

    def create_intent(intent)
      response = HTTParty.post(
        Utils::endpoint(@user_slug, @slug, Utils::INTENTS_SUFFIX),
        headers: {
          'Authorization' => "Token #{@developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: intent.to_json
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 201
    end
  end
end
