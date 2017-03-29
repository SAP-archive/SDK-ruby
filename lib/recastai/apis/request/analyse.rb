# encoding: utf-8

require_relative 'models/response'
require_relative 'utils'
require_relative '../errors'

module RecastAI
  module Analyse
    def analyse_text(text, opts = { token: @token, language: @language })
      raise RecastError.new('Token is missing') if opts[:token].nil?

      body = { text: text }
      body[:language] = opts[:language] unless opts[:language].nil?
      response = HTTParty.post(
        Utils::REQUEST_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{opts[:token]}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      Response.new(response.body)
    end

    def analyse_file(file, opts = { token: @token, language: @language })
      raise RecastError.new('Token is missing') if opts[:token].nil?

      body = { voice: File.new(file) }
      body[:language] = opts[:language] unless opts[:language].nil?
      response = HTTMultiParty.post(
        Utils::REQUEST_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{opts[:token]}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      Response.new(response.body)
    end
  end
end
