# encoding: utf-8

require_relative '../utils'

module RecastAI
  class Entity
    attr_accessor :id, :slug, :name, :color, :custom, :developer_token, :request_token

    def initialize(response = nil, extra_data = nil)
      if response
        if response.kind_of? Hash
          @id = response['id']
          @name = response['name']
          @slug = response['slug']
          @color = response['color']
          @custom = response['custom']
        else
          @name = response
        end
      end
    end

    def as_json(options = {})
      data = {
        name: name,
        slug: slug,
        color: color,
        custom: custom
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end

    def create
      response = HTTParty.post(
        Utils::TRAIN_ENDPOINT + Utils::ENTITIES_SUFFIX + '/',
        headers: {
          'Authorization' => "Token #{developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: self.to_json
      )
      RecastError::raise_if_error response, 201

      return Entity.new JSON.parse(response.body)['results']
    end

    def self.find_all_entities(developer_token)
      response = HTTParty.get(
        Utils::TRAIN_ENDPOINT + Utils::ENTITIES_SUFFIX + '/',
        headers: {
          'Authorization' => "Token #{developer_token}"
        },
        body: self.to_json
      )
      RecastError::raise_if_error response, 200

      JSON.parse(response.body)['results'].map {|entity| Entity.new entity}
    end
  end
end
