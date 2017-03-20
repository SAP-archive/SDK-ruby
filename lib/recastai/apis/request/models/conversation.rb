# encoding: utf-8

require_relative 'action'
require_relative 'entity'
require_relative 'intent'

##
# This class builds a conversation from *_converse
module RecastAI
  class Conversation
    attr_reader :raw, :uuid, :source, :replies, :action, :next_actions, :memory, :entities, :intents,
                :conversation_token, :language, :version, :timestamp, :status

    def initialize(response)
      @raw = response

      response = JSON.parse(response)
      response = response['results']

      @uuid               = response['uuid']
      @source             = response['source']
      @replies            = response['replies']
      @action             = response['action'] ? Action.new(response['action']) : nil
      @next_actions       = response['next_actions'].map{ |i| Action.new(i) }
      @memory             = response['memory'].select{ |_, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      @entities           = response['entities'].flat_map{ |_, e| e.map{ |ee| Entity.new(n, ee) } }
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
    # Returns the first next action provided there is one
    #
    # * *Args* :
    # * *Returns* :
    #   - An instance of Action or nil
    def next_action
      @next_actions.any? ? @next_actions.first : nil
    end

    ##
    # Returns the replies joined with sep
    #
    # * *Args* :
    #   - +sep+ - String, the separator (default: ' ')
    # * *Returns* :
    #   - A String or nil
    def joined_replies(sep = ' ')
      @replies.join(sep)
    end

    ##
    # Returns the first entity in the memory name matches the parameter
    # If no name is provided, returns the full memory
    #
    # * *Args* :
    #   - +key+ - String, the memory's field name
    # * *Returns* :
    #   - An instance of Entity or a Memory
    def get_memory(key = nil)
      return @memory if key.nil?

      @memory.each do |entity|
        return entity if entity.name.casecmp(key.to_s).zero?
      end

      nil
    end

    ##
    # Returns the first intent provided there is one
    #
    # * *Args* :
    # * *Returns* :
    #   - A String or nil
    def intent
      @intents.any? ? @intents.first : nil
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
        body = { conversation_token: conversation_token, memory: memory }
        response = HTTParty.put(
          Utils::CONVERSE_ENDPOINT,
          body: body,
          headers: { Authorization: "Token #{token}" }
        )
        raise(RecastError.new(response.message)) if response.code != 200

        response = JSON.parse(response.body)
        response = response['results']
        response['memory'].select{ |_, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
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
      def reset_memory(token, conversation_token, name = nil)
        body = { conversation_token: conversation_token }
        body[:memory] = { name => nil } unless name.nil?

        response = HTTParty.put(
          Utils::CONVERSE_ENDPOINT,
          body: body,
          headers: { Authorization: "Token #{token}" }
        )
        raise(RecastError.new(response.message)) if response.code != 200

        response = JSON.parse(response.body)
        response = response['results']
        response['memory'].select{ |_, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
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
        response['memory'].select{ |_, e| !e.nil? }.map{ |n, e| Entity.new(n, e) }
      end
    end
  end
end
