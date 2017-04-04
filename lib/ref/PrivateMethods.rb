require "colorized_string"
ColorizedString.colors   
ColorizedString.modes  
module PrivateMethods
  private
  class << self
    def player_choice
      loop do
        print ColorizedString["Choose rock (r), paper (p) or scissors (s): "].colorize(:green)
        choice = gets.chomp.downcasec
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