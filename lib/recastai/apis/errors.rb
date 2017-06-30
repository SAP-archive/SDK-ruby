# encoding: utf-8

module RecastAI
  class RecastError < RuntimeError
    attr_accessor :code

    def self.raise_if_error(response, expected_code = 200)
      if response.code != expected_code
        error = RecastError.new(JSON.parse(response.body)['message'])
        error.code = response.code
        raise error
      end
    end
  end
end
