require "htmlentities"
require "terminal-table"
require_relative "./lib/helpers/presenter"
require_relative "./lib/helpers/requester"
require_relative "./lib/services/trivia"
require_relative "./lib/services/store"

class TriviaGenerator
  include Helpers::Requester
  include Helpers::Presenter

  def initialize
    @filename = ARGV.empty? ? "scores.json" : ARGV.shift
    @store = Services::Store.new(@filename)
    @decoder = HTMLEntities.new
    @score = 0
    @score_data = nil
  end

  def start
    print_welcome_message
    action = select_main_menu

    until action == "exit"
      case action
      when "random"
        @score = 0
        questions = Services::Trivia.random[:results]
        start_trivia(questions)
      when "custom"
        @score = 0
        custom_inputs = custom_trivia
        questions = Services::Trivia.custom(custom_inputs)[:results]
        start_trivia(questions)
      when "scores"
        print_table(@store.sort_scores)
      end
      puts "\n--------------------------------------------------"
      print_welcome_message
      action = select_main_menu
    end

    print_goodbye_message
  end

  def start_trivia(questions)
    questions.each do |question|
      possible_answers = question[:incorrect_answers] << question[:correct_answer]
      options = []
      possible_answers.shuffle.each_with_index do |option, idx|
        options << "#{idx + 1}. #{option}"
      end
      input = ask_question(question, options)
      result = print_result(question[:correct_answer], input, options)
      @score += 10 if result
    end

    puts "\nWell done! Your score is #{@score}" if @score.positive?
    puts "\nNo problem, you can try again. Your score is 0" if @score.zero?
    player_name = save_confirmation
    return unless player_name

    @score_data = { score: @score, name: player_name }
    @store.update_scores_table(@score_data)
  end
end

trivia = TriviaGenerator.new
trivia.start
