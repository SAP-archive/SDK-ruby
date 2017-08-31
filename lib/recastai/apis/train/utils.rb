# encoding: utf-8

module RecastAI
  class Utils
    BOTS_SUFFIX = 'bots'.freeze
    INTENTS_SUFFIX = 'intents'.freeze
    EXPRESSIONS_SUFFIX = 'expressions'.freeze
    GAZETTES_SUFFIX = 'gazettes'.freeze
    SYNONYMS_SUFFIX = 'synonyms'.freeze

    def self.endpoint(user_name, bot_name, *suffixes)
      suffixes = suffixes.join('/')
      "#{Utils::TRAIN_ENDPOINT}users/#{user_name}/#{Utils::BOTS_SUFFIX}/#{bot_name}/#{suffixes}"
    end
  end
end
