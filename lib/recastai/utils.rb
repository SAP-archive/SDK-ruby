module RecastAI
  class Utils
    # Versioning
    MAJOR   = '1'.freeze
    MINOR   = '1'.freeze
    MICRO   = '1'.freeze
    VERSION = "#{MAJOR}.#{MINOR}.#{MICRO}".freeze

    # Endpoints
    API_ENDPOINT = 'https://api.recast.ai/v1/request'.freeze
    WS_ENDPOINT  = 'wss://api.recast.ai/v1/request'.freeze
  end
end
