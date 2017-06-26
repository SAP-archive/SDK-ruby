# encoding: utf-8

module RecastAI
  class Bot
    attr_reader :id, :name, :slug, :description, :public, :strictness,
      :request_token, :developer_token, :children_count, :parent, :intents,
      :actions, :gazettes, :language

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
      @intents = response['intents']
      @actions = response['actions']
      @gazettes = response['gazettes']
      @language = response['language']
    end

  end
end
