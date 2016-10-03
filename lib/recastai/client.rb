# encoding: utf-8

module RecastAI
  class Client
    attr_accessor :token

    def initialize(token = nil, language = nil)
      @token = token
      @language = language
    end

    ##
    # Perform a text request to Recast.AI
    #
    # * *Args* :
    #   - +text+ - String, the text to process
    #   - +options+ - Hash, request's options
    # * *Returns* :
    #   - An instance of Response
    # * *Throws* :
    #   - RecastError
    def text_request(text, options = {})
      token = options[:token] || @token
      raise(RecastError.new('Token is missing')) if token.nil?

      language = options[:language] || @language

      body = { 'text' => text }
      body['language'] = language unless language.nil?
      response = HTTParty.post(
        Utils::API_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise(RecastError.new(response.message)) if response.code != 200

      Response.new(response.body)
    end

    ##
    # Perform a voice file request to Recast.AI
    #
    # * *Args* :
    #   - +file+ - String or File, the voice file to process
    #   - +options+ - Hash, request's options
    # * *Returns* :
    #   - An instance of Response
    # * *Throws* :
    #   - RecastError
    def file_request(file, options = {})
      token = options[:token] || @token
      raise(RecastError.new('Token is missing')) if token.nil?

      language = options[:language] || @language

      body = { 'voice' => File.new(file) }
      body['language'] = language unless language.nil?
      response = HTTMultiParty.post(
        Utils::API_ENDPOINT,
        body: body,
        headers: { 'Authorization' => "Token #{token}" }
      )
      raise(RecastError.new(response.message)) if response.code != 200

      Response.new(response.body)
    end
  end
end
