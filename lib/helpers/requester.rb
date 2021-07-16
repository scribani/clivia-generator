module Helpers
  module Requester
    def select_main_menu
      options = %w[random scores exit]
      gets_with_options(options.join(" | "), options)
    end

    def ask_question(question, options)
      puts "Category: #{question[:category]} | Difficulty: #{question[:difficulty]}"
      puts "Question: #{@decoder.decode(question[:question])}"
      options.each { |option| puts @decoder.decode(option) }
      print "> "
      gets.chomp.strip
    end

    def save_confirmation
      puts "--------------------------------------------------"
      input = gets_with_options("Do you want to save your score? [y/n]", %w[y Y n N])
      return nil if input.downcase == "n"

      puts "Type the name to assign to the score"
      print "> "
      gets.chomp.strip
    end

    def gets_with_options(label, options)
      puts label
      print "> "
      input = gets.chomp.strip
      until options.include? input
        puts "Invalid option"
        print "> "
        input = gets.chomp.strip
      end
      input
    end
  end
end
