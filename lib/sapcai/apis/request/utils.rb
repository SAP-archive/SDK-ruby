# encoding: utf-8

module Sapcai
  class Utils
    # Endpoints
    REQUEST_ENDPOINT = 'https://api.cai.tool.sap/v2/request/'.freeze
    CONVERSE_ENDPOINT = 'https://api.cai.tool.sap/v2/converse/'.freeze

    # Act constants
    ACT_ASSERT = 'assert'.freeze
    ACT_COMMAND = 'command'.freeze
    ACT_WH_QUERY = 'wh-query'.freeze
    ACT_YN_QUERY = 'yn-query'.freeze

    # Type constants
    TYPE_ABBREVIATION = 'abbr:'.freeze
    TYPE_ENTITY = 'enty:'.freeze
    TYPE_DESCRIPTION = 'desc:'.freeze
    TYPE_HUMAN = 'hum:'.freeze
    TYPE_LOCATION = 'loc:'.freeze
    TYPE_NUMBER = 'num:'.freeze

    # Sentiment constants
    SENTIMENT_VPOSITIVE = 'vpositive'.freeze
    SENTIMENT_POSITIVE = 'positive'.freeze
    SENTIMENT_NEUTRAL = 'neutral'.freeze
    SENTIMENT_NEGATIVE = 'negative'.freeze
    SENTIMENT_VNEGATIVE = 'vnegative'.freeze
  end
end
