
module RecastAI
  class Monitor
    attr_reader :token, :language, :proxy

    def initialize(token = nil, language = nil, proxy = nil)
      @token = token
      @language = language
      @proxy = proxy
    end
  end
end
