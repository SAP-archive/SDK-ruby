# encoding: utf-8

require_relative '../utils'
require_relative 'synonym'
require 'json'

module RecastAI
  class Gazette
    attr_accessor :id, :slug, :is_open, :is_activated, :strictness, :synonyms
    alias_method :open?, :is_open
    alias_method :active?, :is_activated
    attr_accessor :bot

    def initialize(response = nil, bot = nil)
      @bot = bot

      @raw = response

      if response
        @id = response['id']
        @slug = response['slug']
        @is_open = response['is_open']
        @is_activated = response['is_activated']
        @synonyms =  (response['synonyms'] || []).map {|e| Synonym.new e, self }
        # TODO: handle entity
      end
    end

    def as_json(options = {})
      data = {
        slug: slug,
        is_open: is_open,
        is_activated: is_activated,
        synonyms: synonyms ? synonyms.map {|e| e.as_json} : nil
      }
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end

    def save!
      response = HTTParty.put(
        Utils::endpoint(@bot.user_slug, @bot.slug, Utils::GAZETTES_SUFFIX, @slug),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: self.to_json
      )
      RecastError::raise_if_error response

      # Recast updates the slug along with the name
      body = JSON.parse(response.body)
      @slug = body['results']['slug']
    end

    def find_all_synonyms
      response = HTTParty.get(
        Utils::endpoint(@bot.user_slug, @bot.slug, Utils::GAZETTES_SUFFIX, @slug, Utils::SYNONYMS_SUFFIX),
        headers: { 'Authorization' => "Token #{@bot.developer_token}" }
      )
      RecastError::raise_if_error response, 200

      body = JSON.parse(response.body)
      @synonyms = body['results'].map {|e| Synonym.new(e, self) }
    end


    def create_synonym(synonym)
      puts synonym
      response = HTTParty.post(
        Utils::endpoint(@bot.user_slug, @bot.slug, Utils::GAZETTES_SUFFIX, @slug, Utils::SYNONYMS_SUFFIX),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}",
          'Content-Type'  => 'application/json'
        },
        body: synonym.to_json
      )
      RecastError::raise_if_error response, 201

      return Synonym.new JSON.parse(response.body)['results'], self
    end

    def delete!
      response = HTTParty.delete(
        Utils::endpoint(@bot.user_slug, @bot.slug, Utils::GAZETTES_SUFFIX, self.slug),
        headers: {
          'Authorization' => "Token #{@bot.developer_token}"
        }
      )
      RecastError::raise_if_error response
    end
  end
end
