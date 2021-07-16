module Helpers
  module Requester
    def select_main_menu
      options = %w[random scores exit]
      puts options.join(" | ")
      print "> "
      input = gets.chomp.strip

      until options.include? input
        puts "Invalid option"
        print "> "
        input = gets.chomp.strip
      end

      input
    end

    def ask_question(question, options)
      puts "Category: #{question[:category]} | Difficulty: #{question[:difficulty]}"
      puts "Question: #{@decoder.decode(question[:question])}"
      options.each { |option| puts @decoder.decode(option) }
      print "> "
      gets.chomp
    end
  end
end
