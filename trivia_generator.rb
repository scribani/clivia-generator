require "htmlentities"
require_relative "./lib/helpers/presenter"
require_relative "./lib/helpers/requester"
require_relative "./lib/services/trivia"

class TriviaGenerator
  include Helpers::Requester

  def initialize
    @decoder = HTMLEntities.new
  end

  def start
    action = select_main_menu
    until action == "exit"
      case action
      when "random" then random_trivia
      when "scores" then puts "high scores table"
      end
      action = select_main_menu
    end
  end

  def random_trivia
    questions = Services::Trivia.random[:results]
    p questions
    # questions are loaded, then let's ask them
  end

  def ask_questions
    # ask each question
    # if response is correct, put a correct message and increase score
    # if response is incorrect, put an incorrect message, and which was the correct answer
    # once the questions end, show user's score and promp to save it
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
