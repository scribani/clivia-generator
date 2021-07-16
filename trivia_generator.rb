require "htmlentities"
require_relative "./lib/helpers/presenter"
require_relative "./lib/helpers/requester"
require_relative "./lib/services/trivia"

class TriviaGenerator
  include Helpers::Requester
  include Helpers::Presenter

  def initialize
    @decoder = HTMLEntities.new
    @score = 0
  end

  def start
    action = select_main_menu
    until action == "exit"
      case action
      when "random"
        @score = 0
        random_trivia
      when "scores" then puts "high scores table"
      end
      action = select_main_menu
    end
  end

  def random_trivia
    questions = Services::Trivia.random[:results]
    questions.each do |question|
      possible_answers = question[:incorrect_answers] << question[:correct_answer]
      shuffled = possible_answers.shuffle
      options = []

      shuffled.each_with_index do |option, idx|
        options << "#{idx + 1}. #{option}"
      end

      input = ask_question(question, options)
      print_result(question[:correct_answer], input, options)
    end
  end

  def save(data)
    # write to file the scores data
  end

  def parse_scores
    # get the scores data from file
  end

  def load_questions
    # ask the api for a random set of questions
    parse_questions
  end

  def parse_questions
    # questions came with an unexpected structure, clean them to make it usable for our purposes
  end

  def print_scores
    # print the scores sorted from top to bottom
  end
end

Helpers::Presenter.print_welcome_message
trivia = TriviaGenerator.new
trivia.start
Helpers::Presenter.print_goodbye_message
