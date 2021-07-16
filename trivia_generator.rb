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
        random_trivia
      when "scores"
        print_table(@store.sort_scores)
      end
      puts "\n--------------------------------------------------"
      print_welcome_message
      action = select_main_menu
    end

    print_goodbye_message
  end

  def random_trivia
    questions = Services::Trivia.random[:results]
    start_trivia(questions)

    puts "\nWell done! Your score is #{@score}"
    player_name = save_confirmation
    return unless player_name

    @score_data = { score: @score, name: player_name }
    @store.update_scores_table(@score_data)
  end

  def start_trivia(questions)
    questions.each do |question|
      possible_answers = question[:incorrect_answers] << question[:correct_answer]
      shuffled = possible_answers.shuffle
      options = []

      shuffled.each_with_index do |option, idx|
        options << "#{idx + 1}. #{option}"
      end

      input = ask_question(question, options)
      result = print_result(question[:correct_answer], input, options)
      @score += 10 if result
    end
  end

  def save(data)
    # write to file the scores data
  end

  def parse_scores
    # get the scores data from file
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end

trivia = TriviaGenerator.new
trivia.start
