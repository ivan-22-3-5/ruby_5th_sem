require_relative 'rock_paper_scissors'

ARGV[0] && RockPaperScissors.play(ARGV[0].downcase.to_sym)
