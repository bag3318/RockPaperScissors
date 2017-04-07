---
layout: default
title: Comparing Code - Play Rock Paper Scissors Game
---

# Comparing Beginner's RPS Code to Advanced RPS Code

**Table of Contents**
- [Comparing Beginner's RPS Code to Advanced RPS Code](#comparing-beginners-rps-code-to-advanced-rps-code)
  - [Beginner's Code](#beginners-code)
    - [Beginner's code Pros](#beginners-code-pros)
    - [Beginner's code Cons](#beginners-code-cons)
    - [What Beginner's Code Looks :ike](#what-beginners-code-looks-ike)
  - [Advanced Code](#advanced-code)
    - [Advanced Code Pros](#advanced-code-pros)
    - [Advanced Code Cons](#advanced-code-cons)
    - [What Advanced Code Looks Like](#what-advanced-code-looks-like)
  - [Site Nav](#site-nav)

## Beginner's Code

### Beginner's code Pros
+ Simple
- Easy to understand
* Short

### Beginner's code Cons
+ Unorganized
- Lacks modularization
* Many `if`s and `else`s

### What Beginner's Code Looks :ike

__`% ruby beginner.rb`__

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

## Advanced Code

### Advanced Code Pros

+ Organized
- Modularized
* Structured

### Advanced Code Cons

+ Long
- Hard to understand

### What Advanced Code Looks Like

__`% ruby advanced.rb`__

```ruby
class PlayRockPaperScissorsGame # define master class
  
  # intiate the colorize gem
  require "colorized_string"
  ColorizedString.colors # import colors; ex: red, green, blue
  ColorizedString.modes  # import modes; ex: bold, italic, underline

  module Constants 
    NTRY_TO_SYM = { # define constants from an entry to a symbol class
      'p' => :PAPER, 
      'r' => :ROCK, 
      's' => :SCISSORS 
    } 
    VALID_ENTRIES = NTRY_TO_SYM.keys # create valid entries
    COMPUTER_CHOICES = NTRY_TO_SYM.values # define computer choices
    WINNERS = [ # define winners
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

  class << self # define a self calling method within the parent class
    def continue(str1,str2,str3) # pass in 3 parameters
      puts  ColorizedString[str1].colorize(:color => :green) 
      print ColorizedString[str2].colorize(:color => :green)
      gets # press enter or return to continue
      puts  str3
    end 
  end 

  continue(Constants::INIT_STRINGS[0], Constants::INIT_STRINGS[1], Constants::INIT_STRINGS[2]) # call continue method

  def initialize # initialize variables
    @player_score = @computer_score = @ties = 0 
  end 
  def play(winning_score) 
    while @player_score < winning_score && @computer_score < winning_score # both the computer's score and the player's score have to be less than the value passed in for the winning score at the end
      puts ColorizedString["Player score: #{@player_score}, "].colorize(:blue) + 
           ColorizedString["Computer score: #{@computer_score}, Ties: #{@ties}"].colorize(:blue) 
      player = PrivateMethods.player_choice 
      computer = Constants::COMPUTER_CHOICES.sample # chooses a "random" option
      puts ColorizedString["\nPlayer chooses #{player.to_s.downcase}"].colorize(:blue) 
      puts ColorizedString["Computer chooses #{computer.to_s.downcase}"].colorize(:blue)
      case PrivateMethods.player_outcome [player, computer] # define a reference call for player and computer for the arrays called in the player_outcome method
      when :WIN
        puts ColorizedString["#{player.to_s.capitalize} beats #{computer.to_s.downcase}, player wins the round"].colorize(:red) 
        @player_score += 1 # @player_score = @player_score + 1
      when :LOSE
        puts ColorizedString["#{computer.to_s.capitalize} beats #{player.to_s.downcase}, computer wins the round"].colorize(:red)
        @computer_score += 1 
      else # since there is only 1 option left, there is no need to define when :TIE
        puts ColorizedString["Tie, choose again"].colorize(:red) 
        @ties += 1
        # since tie is not in the original pass-in argument for the while loop, it will not be affected by the winning score
      end
    end
    puts ColorizedString["\nFinal score: player: #{@player_score}, "].colorize(:blue) +
         ColorizedString["computer: #{@computer_score} (ties: #{@ties})"].colorize(:blue)
    # define a case for the final outcomes  
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
    class << self # make all methods below self calling methods of this class (PlayRockPaperScissorsGame) so that the other methods will not to call their parents of these methods
      def player_choice
        loop do # for loop with no arguments passed in
          print ColorizedString["Choose rock (r), paper (p) or scissors (s): "].colorize(:green)
          choice = gets.chomp.downcase # read user input and convert all to lower case
          # define valid and invalid entries by using an if else-if statement(s)
          if Constants::NTRY_TO_SYM.key?(choice) # if the NTRY_TO_SYM array's key is one of the keys defined in the original array
            return Constants::NTRY_TO_SYM[choice] # return the users choice
          elsif choice != Constants::VALID_ENTRIES # else if it is not one of the valid entries...
            puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:red) # return an error message
          end
          # # one may also do this (albeit more useless):
          # case
          # when Constants::NTRY_TO_SYM.key?(choice)
          #   return Constants::NTRY_TO_SYM[choice]
          # when choice != Constants::VALID_ENTRIES
          #   puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:green) 
          # end
        end 
      end 
      def player_outcome(plays) # define method for the player's outcome while passing in a parameter of type array
        return :WIN  if Constants::WINNERS.include?(plays) # return a win if the one of the sub-arrays in the winners array is called
        return :LOSE if Constants::LOSERS.include?(plays) # return a loss if any of the mapped sub-arrays in the losers constant is present
        return :TIE  if !:WIN | !:LOSE # return a tie if not (!) win or if not loose
      end 
      def final_outcome(pl,co) # define final outcome method
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

------------

## Site Nav

[Home](./) | [Master Code](Code) | [How to Test](Testing) | [How to Build](How_to_Build) | [Contributing](CONTRIBUTING) | [Code of Conduct](CODE_OF_CONDUCT)
