---
layout: default
title: Comparing Code - Play Rock Paper Scissors Game
permalink: /Comparing_Code.html
---

# Comparing Beginner's RPS Code to Advanced RPS Code

**Table of Contents**

- [Comparing Beginner's RPS Code to Advanced RPS Code](#comparing-beginners-rps-code-to-advanced-rps-code)
  - [Beginner's Code](#beginners-code)
    - [Beginner's Code Pros](#beginners-code-pros)
    - [Beginner's Code Cons](#beginners-code-cons)
    - [What Beginner's Code Looks Like](#what-beginners-code-looks-like)
  - [Advanced Code](#advanced-code)
    - [Advanced Code Pros](#advanced-code-pros)
    - [Advanced Code Cons](#advanced-code-cons)
    - [What Advanced Code Looks Like](#what-advanced-code-looks-like)
  - [Site Nav](#site-nav)

## Beginner's Code

### Beginner's Code Pros

+ Simple
- Easy to understand
* Short

### Beginner's Code Cons

+ Unorganized
- Lacks modularization
* Many `if`s and `else`s

### What Beginner's Code Looks Like

__`% ruby beginner-rps.rb`__

```ruby
options = ["rock", "paper", "scissors"]
computer_choice = options[rand(options.length)] 
puts "What's your choice?"
puts "rock, paper, or scissors"
user_input = gets.chomp.downcase # read user input and convert to lower case
loop do 
  if (user_input == "rock" || user_input == "paper" || user_input == "scissors")
    if (user_input == computer_choice)
      puts "We got the same, let's keep playing!"
    elsif (user_input == "rock" && computer_choice == "scissors")
      puts "computer choice is: " + computer_choice + " , you win! :)"
    elsif (user_input == "rock" && computer_choice == "paper")
      puts "computer choice is: " + computer_choice + " ,computer wins :("
    elsif (user_input == "paper" && computer_choice == "scissors")
      puts "computer choice is: " + computer_choice + " ,computer wins :("
    elsif (user_input == "paper" && computer_choice == "rock")
      puts "computer choice is: " + computer_choice + " , you win! :)"
    elsif (user_input == "scissors" && computer_choice == "rock")
      puts "computer choice is: " + computer_choice + " ,computer wins :("
    elsif (user_input == "scissors" && computer_choice == "paper")
      puts "computer choice is: " + computer_choice + " , you win! :)"
    else
      puts "Invalid choice, enter Rock, Paper, or Scissors"
      puts "What's your choice?"
      user_input = gets.chomp.downcase
    end
  end
  break
end
```

## Advanced Code

### Advanced Code Pros

+ Organized
- Modularized
* Structured

### Advanced Code Cons

+ Long
- Hard to understand

### What Advanced Code Looks Like

__`% ruby advanced-rps.rb`__

```ruby
class PlayRockPaperScissorsGame
  
  module RockPaperScissors
    VERSION = "2.5.6"
  end

  # import colorize gem
  require "colorized_string"
  ColorizedString.colors # import colors
  ColorizedString.modes  # import modes (bold, italic, etc...)

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
      [:PAPER   , :ROCK], 
      [:ROCK    , :SCISSORS]
    ] 
    LOSERS = WINNERS.map { |player_choice,computer_choice| [computer_choice,player_choice] } # flip the values in the WINNERS array, returning a loss
    INIT_STRINGS = [
      ColorizedString["You are about to enter a rock-paper-scissors best of 3 match."].colorize(:green), 
      ColorizedString["Press the return/enter key to continue..."].colorize(:green), 
      ""
    ]
  end

  protected_methods :Constants # make constants module protected

  class << self 
    def continue(str1,str2,str3)
      puts  str1
      print str2
      gets
      puts  str3
    end 
  end 

  continue(Constants::INIT_STRINGS[0], Constants::INIT_STRINGS[1], Constants::INIT_STRINGS[2])

  def initialize
    @player_score = @computer_score = @ties = 0 
  end

  def play(winning_score) 
    while @player_score < winning_score && @computer_score < winning_score 
      puts ColorizedString["Player score: #{@player_score}, "].colorize(:blue) + 
           ColorizedString["Computer score: #{@computer_score}, Ties: #{@ties}"].colorize(:blue) 
      player = PrivateMethods.player_choice 
      computer = Constants::COMPUTER_CHOICES.sample # .sample = pick a random choice
      puts ColorizedString["\nPlayer chooses #{player.to_s.downcase}"].colorize(:blue) 
      puts ColorizedString["Computer chooses #{computer.to_s.downcase}"].colorize(:blue)
      case PrivateMethods.player_outcome [player, computer]
      when :WIN
        puts ColorizedString["#{player.to_s.capitalize} beats #{computer.to_s.downcase}, player wins the round"].colorize(:red) 
        @player_score += 1
      when :LOSE
        puts ColorizedString["#{computer.to_s.capitalize} beats #{player.to_s.downcase}, computer wins the round"].colorize(:red)
        @computer_score += 1 
      else
        puts ColorizedString["Tie, choose again"].colorize(:red) 
        @ties += 1
      end
    end
    puts ColorizedString["\nFinal score: player: #{@player_score}, "].colorize(:blue) +
         ColorizedString["computer: #{@computer_score} (ties: #{@ties})"].colorize(:blue)
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
          print ColorizedString["Choose rock (r), paper (p) or scissors (s): "].colorize(:green)
          choice = gets.chomp.downcase # read user input and convert to downcase
          if Constants::NTRY_TO_SYM.key?(choice) # if the choice is one of the keys in NTRY_TO_SYM
            return Constants::NTRY_TO_SYM[choice] # return their choice to be outputed in the play() method
          elsif choice != Constants::VALID_ENTRIES # else if the the choice is not one of the valid entries
            puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:red) # output to invalid entry message
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
        # there will never be a tie because of the play() method
      end 
    end
  end
  
  private_methods :PrivateMethods 

end 

PlayRockPaperScissorsGame.new.play(2) 
```

______________

## Site Nav

[Home](./) | [Master Code](Code) | [How to Test](Testing) | [How to Build](How_to_Build)
