require "httparty"
require "json"

module Services
  class Trivia
    include HTTParty
    base_uri "https://opentdb.com/api.php?"

    def self.random
      response = get("amount=10")
      parse_response(response)
    end

    def self.custom(category:, difficulty:)
      response = get("amount=10&category=#{category}&difficulty=#{difficulty}")
      parse_response(response)
    end

    def self.parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
