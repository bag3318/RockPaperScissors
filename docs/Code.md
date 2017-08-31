---
layout: default
title: Master Code - Play Rock Paper Scissors Game
permalink: /code.html
---

Master Code
===========

**The master code will look like this:**

> Note: the code is a __`Ruby executable`__ and from my [RubyGem](https://rubygems.org/gems/PlayRockPaperScissorsGame)

[//]: # (`$ rps`)
[//]: # (`> rps`)

<!-- `% rps` -->

```
% rps
```

[//]: # "start ruby"
```ruby
#!/usr/bin/env ruby

=begin
|====================================|
| Req Ruby Ver | Req Ruby Gems Ver   |
|--------------|---------------------|
| >= v2.0.0    | >= v2.6.0           |
|====================================|
=end

class PlayRockPaperScissorsGame 

  module RockPaperScissors
    VERSION = "2.9.1" 
  end
  
  # import the colorize gem
  require "colorized_string"
  ColorizedString.colors # import colors; ex: red, green, blue from colorize gem
  ColorizedString.modes  # import modes; ex: bold, italic, underline from colorize gem

  module Constants 
    NTRY_TO_SYM = { # define entry to symbol (key to value)
      'p' => :PAPER   , 'paper'    => :PAPER   ,
      'r' => :ROCK    , 'rock'     => :ROCK    ,
      's' => :SCISSORS, 'scissors' => :SCISSORS
    } 
    VALID_ENTRIES    = NTRY_TO_SYM.keys 
    COMPUTER_CHOICES = NTRY_TO_SYM.values
    WINNERS = [ 
      # format: player choice, computer choice
      [:SCISSORS, :PAPER   ], 
      [:PAPER   , :ROCK    ], 
      [:ROCK    , :SCISSORS]
    ] 
    LOSERS = WINNERS.map { |player_choice,computer_choice| [computer_choice,player_choice] } # this will take the original WINNERS array and flip the symbols, thus returning a loss for the user/player
    INIT_STRINGS = [
      ColorizedString["You are about to enter a rock-paper-scissors best of 3 match."].colorize(:green), 
      ColorizedString["Press the return/enter key to continue..."].colorize(:green)                    , 
      ""
    ]
  end

  protected_methods :Constants 

  class << self # define a self calling method within the parent class
    def continue(str1,str2,str3)
      puts  str1 
      print str2
      gets  # press enter or return to continue
      puts  str3
    end 
  end 

  continue(Constants::INIT_STRINGS[0], Constants::INIT_STRINGS[1], Constants::INIT_STRINGS[2]) 

  def initialize # initialize variables
    @player_score = @computer_score = @ties = 0 
  end 

  def play(winning_score) 
    while @player_score < winning_score && @computer_score < winning_score
      puts ColorizedString["Player score: #{@player_score}, "].colorize(:blue) + 
           ColorizedString["Computer score: #{@computer_score}, Ties: #{@ties}."].colorize(:blue) 
      player = PrivateMethods.player_choice 
      computer = Constants::COMPUTER_CHOICES.sample # chooses a "random" option
      puts ColorizedString["\nPlayer chooses #{player.to_s.downcase}."].colorize(:blue) 
      puts ColorizedString["Computer chooses #{computer.to_s.downcase}."].colorize(:blue)
      case PrivateMethods.player_outcome [player, computer] 
      when :WIN
        puts ColorizedString["#{player.to_s.capitalize} beats #{computer.to_s.downcase}, player wins the round."].colorize(:red) 
        @player_score += 1 # @player_score = @player_score + 1
      when :LOSE
        puts ColorizedString["#{computer.to_s.capitalize} beats #{player.to_s.downcase}, computer wins the round."].colorize(:red)
        @computer_score += 1 
      else 
        puts ColorizedString["Tie, choose again"].colorize(:red) 
        @ties += 1
      end
    end
    puts ColorizedString["\nFinal score: player: #{@player_score}, "].colorize(:blue) +
         ColorizedString["computer: #{@computer_score} (ties: #{@ties})."].colorize(:blue)
    case PrivateMethods.final_outcome(@player_score, @computer_score)
    when :WIN 
      puts ColorizedString["Player wins!"].colorize(:red) 
    when :LOSE
      puts ColorizedString["Computer wins!"].colorize(:red)
    else 
      puts ColorizedString["It's a tie!"].colorize(:red) 
    end 
    gets
  end 

  module PrivateMethods 
    class << self 
      def player_choice
        loop do 
          print ColorizedString["Choose: Rock (r), Paper (p), or Scissors (s): "].colorize(:green)
          choice = gets.chomp.downcase 
          if Constants::NTRY_TO_SYM.key?(choice)
            return Constants::NTRY_TO_SYM[choice] 
          elsif choice != Constants::VALID_ENTRIES
            puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:red) 
          else
            return nil
          end
        end 
      end 

      def player_outcome(plays)
        # plays = [player_choice, computer_choice]
        return :WIN  if Constants::WINNERS.include?(plays) 
        return :LOSE if Constants::LOSERS.include?(plays)
        return :TIE  if !:WIN | !:LOSE 
      end

      def final_outcome(pl,co)
        return :WIN  if pl > co 
        return :LOSE if pl < co
        # there will never be a tie for the final outcome due to the code in the play() method
      end 
    end
  end
  
  private_methods :PrivateMethods 

end 

PlayRockPaperScissorsGame.new.play(2) # call the play method and pass in 3 (0, 1, 2) for the winning score
```

[//]: # "end ruby"
