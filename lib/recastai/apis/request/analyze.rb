
require_relative '../errors'
require_relative 'utils'
require_relative 'models/response'

module RecastAI
  module Analyze
    def analyze_text(text, token = nil, language = nil, proxy = nil)
      token ||= @token
      raise(RecastError.new('Token is missing')) if token.nil?

      language ||= @language

      body = { text: text }
      body[:language] = language unless language.nil?
      response = HTTParty.post(
        Utils::REQUEST_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise(RecastError.new(response.message)) if response.code != 200

      Response.new(response.body)
    end

    def analyze_file(file, token = nil, language = nil, proxy = nil)
      token ||= @token
      raise(RecastError.new('Token is missing')) if token.nil?

      language ||= @language

      body = { voice: File.new(file) }
      body[:language] = language unless language.nil?
      response = HTTMultiParty.post(
        Utils::REQUEST_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise(RecastError.new(response.message)) if response.code != 200

      Response.new(response.body)
    end
  end
end
