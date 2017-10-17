# encoding: utf-8

module RecastAI
  class Utils
    # Versioning
    MAJOR = '3'.freeze
    MINOR = '1'.freeze
    PATCH = '3'.freeze
    VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}".freeze

    # Endpoints
    TRAIN_ENDPOINT = 'https://api.recast.ai/v2/'.freeze
    CONNECT_ENDPOINT = 'https://api.recast.ai/connect/v1/'.freeze
    HOST_ENDPOINT = 'https://api.recast.ai/host/v1/'.freeze
    MONITOR_ENDPOINT = 'https://api.recast.ai/monitor/v1/'.freeze
    BUILD_ENDPOINT = 'https://api.recast.ai/build/v1'.freeze
  end
end
