# encoding: utf-8

require_relative 'models/response'
require_relative 'utils'
require_relative '../errors'

module RecastAI
  module Analyse
    def analyse_text(text, token: nil, language: nil)
      token ||= @token
      raise RecastError.new('Token is missing') if token.nil?

      language ||= @language

      body = { text: text }
      body[:language] = language unless language.nil?
      response = HTTParty.post(
        Utils::REQUEST_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise RecastError.new(JSON.parse(response.body)['message']) if response.code != 200

      Response.new(JSON.parse(response.body))
    end
  end
end
