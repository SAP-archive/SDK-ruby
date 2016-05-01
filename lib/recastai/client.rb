module RecastAI
  class Client
    attr_accessor :token

    def initialize(token = nil)
      @token = token
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
      raise(RecastError.new('Token is missing', 400)) if token.nil?

      response = HTTParty.post(Utils::API_ENDPOINT,
                               body: { 'text' => text },
                               headers: { 'Authorization' => "Token #{token}" }
                              )
      raise(RecastError.new(response.message, response.code)) if response.code != 200

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
      raise(RecastError.new('Token is missing', 400)) if token.nil?

      response = HTTMultiParty.post(Utils::API_ENDPOINT,
                                    body: { 'voice' => File.new(file) },
                                    headers: { 'Authorization' => "Token #{token}" }
                                   )
      raise(RecastError.new(response.message, response.code)) if response.code != 200

      Response.new(response.body)
    end
  end
end
