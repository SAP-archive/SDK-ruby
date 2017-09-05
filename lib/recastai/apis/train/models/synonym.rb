# encoding: utf-8

require_relative '../utils'
require_relative 'language'

module RecastAI
  class Synonym
    attr_accessor :id, :slug, :value, :language
    attr_accessor :gazette

    def initialize(response = nil, gazette = nil)
      @gazette = gazette
      @raw = response

      if response
        @id = response['id']
        @slug = response['slug']
        @value = response['value']
        @language = RecastAI::Language.new response['language']
      end
    end

    def as_json(options = {})
      data = {
        slug: slug,
        value: value,
        language: language.as_json
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end

    def save!
      response = HTTParty.put(
        Utils::endpoint(@gazette.bot.user_slug, @gazette.bot.slug, Utils::GAZETTES_SUFFIX, @gazette.slug, Utils::SYNONYMS_SUFFIX, self.slug),
        headers: {
          'Authorization' => "Token #{@gazette.bot.developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: self.to_json
      )
      RecastError::raise_if_error response
    end

    def delete!
      response = HTTParty.delete(
        Utils::endpoint(@gazette.bot.user_slug, @gazette.bot.slug, Utils::GAZETTES_SUFFIX, @gazette.slug, Utils::SYNONYMS_SUFFIX, self.slug),
        headers: {
          'Authorization' => "Token #{@gazette.bot.developer_token}"
        }
      )
      RecastError::raise_if_error response, 200
    end
  end
end
