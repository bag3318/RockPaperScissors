---
layout: default
title: Comparing Code - Play Rock Paper Scissors Game
permalink: /comparing_code.html
---

# Comparing Beginner's RPS Code to Advanced RPS Code

**Table of Contents**

- [Comparing Beginner's RPS Code to Advanced RPS Code](#comparing-beginners-rps-code-to-advanced-rps-code)
  - [Beginner's Code](#beginners-code)
    - [Beginner's Code Pros](#beginners-code-pros)
    - [Beginner's Code Cons](#beginners-code-cons)
    - [Beginner's Analysis](#beginners-analysis)
    - [What Beginner's Code Looks Like](#what-beginners-code-looks-like)
  - [Advanced Code](#advanced-code)
    - [Advanced Code Pros](#advanced-code-pros)
    - [Advanced Code Cons](#advanced-code-cons)
    - [Advanced Analysis](#advanced-analysis)
    - [What Advanced Code Looks Like](#what-advanced-code-looks-like)

<!-- 
`% rps`
 -->

## Beginner's Code

### Beginner's Code Pros

+ Simple
- Easy to understand
* Short

### Beginner's Code Cons

+ Unorganized
- Lacks modularization
* Many `if`/`elsif`/`else` statements

### Beginner's Analysis

It is common for beginners to use many repetitive statements when coding a simple Ruby app. 

In this case, using many `if`/`elsif`/`else` statements is typical beginner code formatting when programming a rock-paper-scissors game.

The beginner's code might also show redundancy by programming more than what needs to be coded (this situation is different for advanced Ruby programmers).

Most beginners' code lacks modularization and a solid code structure; thus making it very unorganized. 

While beginners' code might look simple and easy to understand, it is not always the most efficient. 

In this particular case, the advanced code is longer and more confusing, though it has more modularization and professionalism attached to it (in some cases, it will actually run faster than the beginner's code).

### What Beginner's Code Looks Like

[//]: # "`% ruby beginner-rps.rb`"
 
```bash
% ruby beginner-rps.rb
```

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

### Advanced Analysis

An advanced coder's code could be longer or shorter than a beginner's code. 

Advanced code usually has seldom repetition and more subtle programming. 

Advanced coders tend to shy away from many `if`, `elsif`, &amp; `else` statements. This is primarily due to the way an advanced coder thinks. One might replace multiple `elsif`s with a `case` statement --adding more structure and organization to the code--.

Subtlety is usually painted all over advanced ruby code. While this does make the code harder to understand, it certainly adds more structure professionalism to the code. 

### What Advanced Code Looks Like

[//]: # (`% ruby advanced-rps.rb`)

```shell
% ruby advanced-rps.rb
```

```ruby
class PlayRockPaperScissorsGame

  module Constants 
    NTRY_TO_SYM = { # define entry to symbol (key to value)
      'p' => :PAPER   , 
      'r' => :ROCK    , 
      's' => :SCISSORS 
    } 
    VALID_ENTRIES    = NTRY_TO_SYM.keys 
    COMPUTER_CHOICES = NTRY_TO_SYM.values
    WINNERS = [ 
      # format: player choice, computer choice
      [:SCISSORS, :PAPER   ], 
      [:PAPER   , :ROCK    ], 
      [:ROCK    , :SCISSORS]
    ] 
    LOSERS = WINNERS.map { |player_choice,computer_choice| [computer_choice,player_choice] } # flip the values in the WINNERS array, returning a loss
    INIT_STRINGS = [
      "You are about to enter a rock-paper-scissors best of 3 match.", 
      "Press the return/enter key to continue...", 
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
      puts "Player score: #{@player_score}, " + 
           "Computer score: #{@computer_score}, Ties: #{@ties}" 
      player = PrivateMethods.player_choice 
      computer = Constants::COMPUTER_CHOICES.sample # .sample = pick a random choice
      puts "\nPlayer chooses #{player.to_s.downcase}" 
      puts "Computer chooses #{computer.to_s.downcase}"
      case PrivateMethods.player_outcome [player, computer]
      when :WIN
        puts "#{player.to_s.capitalize} beats #{computer.to_s.downcase}, player wins the round" 
        @player_score += 1
      when :LOSE
        puts "#{computer.to_s.capitalize} beats #{player.to_s.downcase}, computer wins the round"
        @computer_score += 1 
      else
        puts "Tie, choose again" 
        @ties += 1
      end
    end
    puts "\nFinal score: player: #{@player_score}, " +
         "computer: #{@computer_score} (ties: #{@ties})"
    case PrivateMethods.final_outcome(@player_score, @computer_score)
    when :WIN 
      puts "Player wins!" 
    when :LOSE
      puts "Computer wins!"
    else 
      puts "It's a tie!" 
    end 
    gets
  end 

  module PrivateMethods 
    class << self 
      def player_choice
        loop do 
          print "Choose rock (r), paper (p) or scissors (s): "
          choice = gets.chomp.downcase 
          if Constants::NTRY_TO_SYM.key?(choice) 
            return Constants::NTRY_TO_SYM[choice] 
          elsif choice != Constants::VALID_ENTRIES 
            puts "That entry is invalid. Please re-enter." entry message
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
        # there will never be a tie for the final outcome because of the play() method
      end 
    end
  end
  
  private_methods :PrivateMethods 

end 

PlayRockPaperScissorsGame.new.play(2) 
```
