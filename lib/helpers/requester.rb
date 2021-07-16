module Helpers
  module Requester
    def select_main_menu
      options = %w[random custom scores exit]
      gets_with_options(options.join(" | "), options)
    end

    def ask_question(question, options)
      puts "\nCategory: #{question[:category]} | Difficulty: #{question[:difficulty]}"
      puts "Question: #{@decoder.decode(question[:question])}"
      options.each { |option| puts @decoder.decode(option) }
      print "> "
      gets.chomp.strip
    end

    def save_confirmation
      puts "\n--------------------------------------------------\n\n"
      input = gets_with_options("Do you want to save your score? [y/n]", %w[y Y n N])
      return nil if input.downcase == "n"

      puts "Type the name to assign to the score"
      print "> "
      gets.chomp.strip
    end

    def custom_trivia
      category_label = "Select a category id (between 9 and 32)"
      difficulty_label = "Select a difficulty (easy, medium or hard)"
      category_options = Array.new(24) { |i| (i + 9).to_s }
      category = gets_with_options(category_label, category_options)
      difficulty = gets_with_options(difficulty_label, %w[easy medium hard])
      { category: category, difficulty: difficulty }
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
