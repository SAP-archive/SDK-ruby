# encoding: utf-8

require_relative '../utils'
require_relative 'intent'
require_relative 'gazette'

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
        @gazettes = response['gazettes'].map {|g| Gazette.new(g, self) }
        @actions = response['actions']
        @language = response['language']
        @user_nickname = response['user']['nickname']
      end
    end

    def find_intent_by_slug(slug)
      response = HTTParty.get(
        Utils::endpoint(@user_slug, @slug, Utils::INTENTS_SUFFIX, slug),
        headers: { 'Authorization' => "Token #{@developer_token}" }
      )
      RecastError::raise_if_error response, 200

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
      RecastError::raise_if_error response, 201

      return Intent.new JSON.parse(response.body)['results'], self
    end

    def find_all_intents
      response = HTTParty.get(
        Utils::endpoint(@user_slug, @slug, Utils::INTENTS_SUFFIX),
        headers: { 'Authorization' => "Token #{@developer_token}" }
      )
      RecastError::raise_if_error response, 200

      body = JSON.parse(response.body)
      @intents = body['results'].map {|i| Intent.new(i, self) }
    end

    def find_all_gazettes
      response = HTTParty.get(
        Utils::endpoint(@user_slug, @slug, Utils::GAZETTES_SUFFIX),
        headers: { 'Authorization' => "Token #{@developer_token}" }
      )
      RecastError::raise_if_error response, 200

      body = JSON.parse(response.body)
      @gazettes = body['results'].map {|g| Gazette.new(g, self) }
    end

    def find_gazette_by_slug(slug)
      response = HTTParty.get(
        Utils::endpoint(@user_slug, @slug, Utils::GAZETTES_SUFFIX, slug),
        headers: { 'Authorization' => "Token #{@developer_token}" }
      )
      RecastError::raise_if_error response, 200

      body = JSON.parse(response.body)
      Gazette.new(body['results'], self)
    end

    def create_gazette(gazette)
      response = HTTParty.post(
        Utils::endpoint(@user_slug, @slug, Utils::GAZETTES_SUFFIX),
        headers: {
          'Authorization' => "Token #{@developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: gazette.to_json
      )
      RecastError::raise_if_error response, 201

      return Gazette.new JSON.parse(response.body)['results'], self
    end

    def empty!
      self.find_all_intents.each do |i|
        i.delete!
      end
    end
  end
end
