---
# start YAML
layout: default
title: Comparing Code - Play Rock Paper Scissors Game
permalink: /Comparing_Code.html
# end YAML
---

[//]: # (start markdown)

# Comparing Beginner's RPS Code to Advanced RPS Code

**Table of Contents**

- [Comparing Beginner's RPS Code to Advanced RPS Code](#comparing-beginners-rps-code-to-advanced-rps-code)
  - [Beginner's Code](#beginners-code)
    - [Beginner's Code Pros](#beginners-code-pros)
    - [Beginner's Code Cons](#beginners-code-cons)
    - [What Beginner's Code Looks :ike](#what-beginners-code-looks-ike)
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

[//]: # (end markdown)

[//]: # (start ruby)
```ruby
options = ["rock", "paper", "scissors"]
computer_choice = options[rand(options.length)] 
 # the above line chooses a random pick in the options array, and the `options.length` means to choose from however many options there are in the `options` array
puts "What's your choice?"
puts "rock, paper, or scissors"
user_input = gets.chomp.downcase # `gets.chomp` reads user input, .downcase is like `.toLowerCase()` in javascript
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
    end
    else 
    puts "Invalid choice, enter Rock, Paper, or Scissors"
    puts "What's your choice?"
    user_input = gets.chomp.downcase # have the user choose again
  end
  break # break the loop after all the above has been completed
end
```
[//]: # (end ruby)

[//]: # (start markdown)

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

[//]: # (end markdown)

[//]: # (start ruby)
```ruby
class PlayRockPaperScissorsGame
  
  # intiate the colorize gem
  require "colorized_string"
  ColorizedString.colors # import colors; ex: red, green, blue
  ColorizedString.modes  # import modes; ex: bold, italic, underline

  module Constants 
    NTRY_TO_SYM = { 
      'p' => :PAPER, 
      'r' => :ROCK, 
      's' => :SCISSORS 
    } 
    VALID_ENTRIES = NTRY_TO_SYM.keys 
    COMPUTER_CHOICES = NTRY_TO_SYM.values 
    WINNERS = [ 
      # format: player choice, computer choice
      [:SCISSORS, :PAPER], 
      [:PAPER   , :ROCK], 
      [:ROCK    , :SCISSORS]
    ] 
    LOSERS = WINNERS.map { |pc,cc| [cc,pc] } # this will take the original WINNERS array and flip the symbols, thus returning a loss for the user/player
    INIT_STRINGS = [
      ColorizedString["You are about to enter a rock-paper-scissors best of 3 match."].colorize(:green), 
      ColorizedString["Press the return/enter key to continue..."].colorize(:green), 
      ""
    ]
  end

  protected_methods :Constants # make the constants module protected

  class << self 
    def continue(str1,str2,str3)
      puts  ColorizedString[str1].colorize(:color => :green) 
      print ColorizedString[str2].colorize(:color => :green)
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
      computer = Constants::COMPUTER_CHOICES.sample 
      puts ColorizedString["\nPlayer chooses #{player.to_s.downcase}"].colorize(:blue) 
      puts ColorizedString["Computer chooses #{computer.to_s.downcase}"].colorize(:blue)
      case PrivateMethods.player_outcome [player, computer]
      when :WIN
        puts ColorizedString["#{player.to_s.capitalize} beats #{computer.to_s.downcase}, player wins the round"].colorize(:red) 
        @player_score += 1 # @player_score = @player_score + 1
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
          choice = gets.chomp.downcase 
          if Constants::NTRY_TO_SYM.key?(choice)
            return Constants::NTRY_TO_SYM[choice] 
          elsif choice != Constants::VALID_ENTRIES
            puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:red)
          end
        end 
      end 
      def player_outcome(plays)
        return :WIN  if Constants::WINNERS.include?(plays) 
        return :LOSE if Constants::LOSERS.include?(plays)
        return :TIE  if !:WIN | !:LOSE
      end 
      def final_outcome(pl,co)
        return :WIN  if pl > co 
        return :LOSE if pl < co
        return :TIE  if pl = co # this can never happen due to the code in the play method, but it is worth noting
      end 
    end
  end
  
  private_methods :PrivateMethods # make the PrivateMethods module private

end 

PlayRockPaperScissorsGame.new.play(2) # call the play method and pass in 3 (0, 1, 2) for the winning score
```
[//]: # (end ruby)

[//]: # (start markdown)

------------

## Site Nav

[Home](./) | [Master Code](Code) | [How to Test](Testing) | [How to Build](How_to_Build) | [Contributing](CONTRIBUTING) | [Code of Conduct](CODE_OF_CONDUCT)

[//]: # (end markdown)
