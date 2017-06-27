# encoding: utf-8

require_relative '../utils'

module RecastAI
  class Language
    attr_accessor :id, :name, :slug, :isocode, :is_activated

    def initialize(response = nil)
      @raw = response

      if response
        @id = response['id']
        @name = response['name']
        @slug = response['slug']
        @isocode = response['isocode']
        @is_activated = response['is_activated']
      end
    end

    def as_json(options = {})
      data = {
        isocode: isocode,
      }
      data[:name] = name if name
      data[:slug] = slug if slug
      data[:is_activated] = is_activated if is_activated
      data[:id] = id if id

      data
    end

    def to_json(*a)
      as_json.to_json
    end
  end
end
