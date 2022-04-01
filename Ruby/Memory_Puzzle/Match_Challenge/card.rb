require_relative "board.rb"
require_relative "game.rb"
require_relative "human_player.rb"

class Card 

    attr_reader :face_value
    attr_accessor :face_up 

    def initialize(card)
        @face_value = card 
        @face_up = false   
    end 

    def display 
        if @face_up == true 
            @face_value 
        else 
            '-'
        end 
    end 

    def hide 
        @face_up = false 
    end 

    def reveal 
        @face_up = true 
    end 

end 