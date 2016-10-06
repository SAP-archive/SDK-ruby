# encoding: utf-8

##
# This class builds a conversation from *_converse
module RecastAI
  class Conversation
    attr_reader :raw
    attr_reader :uuid
    attr_reader :source
    attr_reader :replies
    attr_reader :action
    attr_reader :next_actions
    attr_reader :memory
    attr_reader :entities
    attr_reader :intents
    attr_reader :conversation_token
    attr_reader :language
    attr_reader :version
    attr_reader :timestamp
    attr_reader :status

    def initialize(response)
      @raw = response

      response = JSON.parse(response)
      response = response['results']

      @uuid               = response['uuid']
      @source             = response['source']
      @replies            = response['replies']
      @action             = Action.new(response['action'])
      @next_actions       = response['next_actions'].map{ |i| Action.new(i) }
      @memory             = response['memory'].select{ |n, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      @entities           = response['entities'].flat_map{ |n, e| e.map{ |ee| Entity.new(n, ee) } }
      @intents            = response['intents'].map{ |i| Intent.new(i) }
      @conversation_token = response['conversation_token']
      @language           = response['language']
      @version            = response['version']
      @timestamp          = response['timestamp']
      @status             = response['status']
    end

    ##
    # Returns the first reply provided there is one
    #
    # * *Args* :
    # * *Returns* :
    #   - A String or nil
    def reply
      @replies.any? ? @replies.first : nil
    end

    ##
    # Returns the replies joined with sep
    #
    # * *Args* :
    #   - +sep+ - String, the separator (default: ' ')
    # * *Returns* :
    #   - A String or nil
    def joined_replies(sep=' ')
      @replies.any? ? @replies.first : nil
    end

    ##
    # Returns the first entity in the memory name matches the parameter
    # If no name is provided, returns the full memory
    #
    # * *Args* :
    #   - +name+ - String, the memory's field name
    # * *Returns* :
    #   - An instance of Entity or a Memory
    def get_memory(name=nil)
      return @memory if name.nil?

      @memory[name]
    end

    class << self
      ##
      # Merges the conversation memory with the one given
      #
      # * *Args* :
      #   - +token+ - String, your request_token
      #   - +conversation_token+ String, the token of the conversation whose memory will be updated
      #   - +memory+ Hash, the memory you want to update with
      # * *Returns* :
      #   - An updated Memory
      # * *Throws* :
      #   - RecastError
      def set_memory(token, conversation_token, memory)
        body = { conversation_token: conversation_token, memory: JSON.generate(memory) }
        response = HTTParty.put(
          Utils::CONVERSE_ENDPOINT,
          body: body,
          headers: { Authorization: "Token #{token}" }
        )
        raise(RecastError.new(response.message)) if response.code != 200

        response = JSON.parse(response.body)
        response = response['results']
        response['memory'].select{ |n, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      end

      ##
      # Reset the conversation memory fully or partially with the one given
      #
      # * *Args* :
      #   - +token+ - String, your request_token
      #   - +conversation_token+ String, the token of the conversation whose memory will be updated
      #   - +memory+ Hash, the memory you want to update with
      # * *Returns* :
      #   - A fully or partially reset Memory
      # * *Throws* :
      #   - RecastError
      def reset_memory(token, conversation_token, name=nil)
        memory = {}
        memory[name] = nil unless name.nil?

        body = { conversation_token: conversation_token }
        body[:memory] = JSON.generate(memory) unless memory.empty?
        response = HTTParty.put(
          Utils::CONVERSE_ENDPOINT,
          body: body,
          headers: { Authorization: "Token #{token}" }
        )
        raise(RecastError.new(response.message)) if response.code != 200

        response = JSON.parse(response.body)
        response = response['results']
        response['memory'].select{ |n, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      end

      ##
      # Resets the conversation state by setting every memory field to nil,
      # all actions to not done, and the last action to nil
      #
      # * *Args* :
      #   - +token+ - String, your request_token
      #   - +conversation_token+ - String, the token of the conversation to reset
      # * *Returns* :
      #   - A fully reset Memory
      # * *Throws* :
      #   - RecastError
      def reset_conversation(token, conversation_token)
        body = { conversation_token: conversation_token }
        response = HTTParty.delete(
          Utils::CONVERSE_ENDPOINT,
          body: body,
          headers: { Authorization: "Token #{token}" }
        )
        raise(RecastError.new(response.message)) if response.code != 200

        response = JSON.parse(response.body)
        response = response['results']
        response['memory'].select{ |n, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      end
    end
  end
end
