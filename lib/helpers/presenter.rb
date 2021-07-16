module Helpers
  module Presenter
    def print_welcome_message
      puts [
        "#########################################",
        "#      Welcome to Trivia Generator      #",
        "#########################################"
      ]
    end

    def print_goodbye_message
      puts [
        "#########################################",
        "#   Thanks for using Trivia Generator   #",
        "#########################################"
      ]
    end

    def print_result(correct_answer, player_input, options)
      player_answer = options.find { |option| option.match?(/^#{player_input}\./) }
      decoded_player_answer = @decoder.decode(player_answer[3..-1]) # 1. &#039;archipelago&#039; => 'archipelago'
      result = player_answer.match? correct_answer

      if result
        puts "#{decoded_player_answer}... Correct!"
      else
        puts "#{decoded_player_answer}... Incorrect!"
        puts "The correct answer was: #{@decoder.decode(correct_answer)}"
      end

      result
    end

    def print_table(score_list)
      table = Terminal::Table.new
      table.title = "Top Scores"
      table.headings = %w[Name Score]
      table.rows = score_list.map { |item| [item[:name], item[:score]] } unless score_list.empty?
      puts table
    end
  end
end
