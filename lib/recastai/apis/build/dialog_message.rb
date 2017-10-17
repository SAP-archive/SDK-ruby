module RecastAI
  class DialogMessage
    attr_reader :type, :content

    def initialize(msg)
      raise RecastAI::RecastError('Invalid message format') unless message_is_valid(msg)
      @type = msg['type']
      @content = msg['content']
    end

    private

    def message_is_valid(msg)
      msg.is_a?(Hash) && msg.key?('type') && msg.key?('content')
    end
  end
end
