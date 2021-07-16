module Helpers
  module Presenter
    def self.print_welcome_message
      puts [
        "#########################################",
        "#      Welcome to Trivia Generator      #",
        "#########################################"
      ]
    end

    def self.print_goodbye_message
      puts [
        "#########################################",
        "#   Thanks for using Trivia Generator   #",
        "#########################################"
      ]
    end
  end
end
