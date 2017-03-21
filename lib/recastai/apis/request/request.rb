
require_relative 'analyze'
require_relative 'converse'

module RecastAI
  class Request
    include Converse
    include Analyze

    attr_reader :token, :language, :proxy

    def initialize(token = nil, language = nil, proxy = nil)
      @token = token
      @language = language
      @proxy = proxy
    end
  end
end
