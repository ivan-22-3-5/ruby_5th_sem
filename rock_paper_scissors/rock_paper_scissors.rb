# frozen_string_literal: true

module RockPaperScissors
  class UnsupportedChoice < StandardError; end

  class GameResult
    WIN = "You won!"
    TIE = "Seems like it's a tie"
    LOSS = "You lost!"
  end

  RULES = { rock: :scissors, paper: :rock, scissors: :paper } # key beats value

  def self.play(user_choice)
    machine_choice = RULES.keys.sample
    result = get_game_result user_choice, machine_choice

    puts "I chose #{machine_choice}"
    puts result
  end

  private_class_method def self.get_game_result(user_choice, machine_choice)
    unless RULES.keys.include? user_choice
      raise UnsupportedChoice.new "Apparently, someone doesn't wanna play by the rules"
    end

    if user_choice == machine_choice
      return GameResult::TIE
    end
    RULES[user_choice] == machine_choice ? GameResult::WIN : GameResult::LOSS
  end
end
