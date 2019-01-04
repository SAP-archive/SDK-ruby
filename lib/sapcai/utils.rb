# encoding: utf-8

module Sapcai
  class Utils
    # Versioning
    MAJOR = '4'.freeze
    MINOR = '0'.freeze
    PATCH = '0'.freeze
    VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}".freeze

    # Endpoints
    TRAIN_ENDPOINT = 'https://api.cai.tools.sap/v2/'.freeze
    CONNECT_ENDPOINT = 'https://api.cai.tools.sap/connect/v1/'.freeze
    HOST_ENDPOINT = 'https://api.cai.tools.sap/host/v1/'.freeze
    MONITOR_ENDPOINT = 'https://api.cai.tools.sap/monitor/v1/'.freeze
    BUILD_ENDPOINT = 'https://api.cai.tools.sap/build/v1'.freeze
  end
end
