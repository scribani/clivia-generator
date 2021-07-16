require "httparty"
require "json"

module Services
  class Trivia
    include HTTParty
    base_uri "https://opentdb.com"

    def self.random
      response = get("/api.php?amount=10")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
