class Player 

    attr_reader :name 

    def initialize(name)
        @name = name 
    end 

    def guess 
        player_guess = gets.chomp.downcase
    end 

    def alert_invalid_guess
        print "\nInvalid guess. Enter a letter that continues spelling the word fragment."
    end 

end 