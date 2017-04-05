require "colorized_string"
ColorizedString.colors   
ColorizedString.modes  
module Constants 
  NTRY_TO_SYM = { 
    'p' => :PAPER, 
    'r' => :ROCK, 
    's' => :SCISSORS 
  } 
  VALID_ENTRIES = NTRY_TO_SYM.keys 
  COMPUTER_CHOICES = NTRY_TO_SYM.values
  WINNERS = [
    [:SCISSORS, :PAPER], 
    [:PAPER, :ROCK], 
    [:ROCK, :SCISSORS]
  ] # format: player choice, computer choice
  LOSERS = WINNERS.map { |i,j| [j,i] } # this will take the original WINNERS array and flip the symbols, thus returning a loss for the user/player
  INIT_STRINGS = [
    ColorizedString["You are about to enter a rock-paper-scissors best of 3 match."].colorize(:green), 
    ColorizedString["Press the return/enter key to continue..."].colorize(:green), 
    ""
  ]
end
