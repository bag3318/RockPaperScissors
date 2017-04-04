=begin
|====================================|
| Req Ruby Ver | Req Ruby Gems Ver   |
|--------------|---------------------|
| >= v2.0.0    | >= v2.6.10          |
|====================================|
=end

class RakeTest # create test

  require "colorized_string"
  ColorizedString.colors
  ColorizedString.modes

  module Constants 
    protected
    NTRY_TO_SYM = { 'p' => :PAPER,  'r' => :ROCK, 's' => :SCISSORS } 
    VALID_ENTRIES = NTRY_TO_SYM.keys 
    COMPUTER_CHOICES = NTRY_TO_SYM.values
    WINNERS = [[:SCISSORS, :PAPER], [:PAPER, :ROCK], [:ROCK, :SCISSORS]] # format: player choice, computer choice
    LOSERS = WINNERS.map { |i,j| [j,i] } # this will take the original WINNERS array and flip the symbols, thus returning a loss for the user/player
    INIT_STRINGS = ["You are about to enter a rock-paper-scissors best of 3 match.", "Press the return/enter key to continue...", ""]
  end
  class << self
    def continue(str1, str2, str3)
      puts  ColorizedString[str1].colorize(:color => :green) 
      print ColorizedString[str2].colorize(:color => :green)
      gets 
      puts  ColorizedString[str3].colorize(:color => :green)
    end 
  end 
  continue(Constants::INIT_STRINGS[0], Constants::INIT_STRINGS[1], Constants::INIT_STRINGS[2])
  def initialize
    @player_score = @computer_score = @ties = 0 
  end 
  def testPlay(winning_score) 
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
    private
    class << self
      def player_choice
        loop do
          print ColorizedString["Choose rock (r), paper (p) or scissors (s): "].colorize(:green)
          choice = gets.chomp.downcase
          if Constants::NTRY_TO_SYM.key?(choice)
            return Constants::NTRY_TO_SYM[choice]
          elsif choice != Constants::VALID_ENTRIES
            puts ColorizedString["That entry is invalid. Please re-enter"].colorize(:green)
          end
          # # one may also do this:
          # case
          # when Constants::NTRY_TO_SYM.key?(choice)
          #   return Constants::NTRY_TO_SYM[choice]
          # when choice != Constants::VALID_ENTRIES
          #   puts ColorizedString["That entry is invalid. Please re-enter."].colorize(:green) 
          # end
        end 
      end 
      def player_outcome(plays)
        return :WIN  if Constants::WINNERS.include?(plays)
        return :LOSE if Constants::LOSERS.include?(plays)
        return :TIE  if !:WIN | !:LOSE
      end 
      def final_outcome(pl, co) 
        return :WIN  if pl > co 
        return :LOSE if pl < co
        return :TIE  if pl = co 
      end 
    end
  end
end 

RakeTest.new.testPlay(2) # best of 3

