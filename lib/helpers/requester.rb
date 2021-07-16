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
  end
end
