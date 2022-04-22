require_relative 'player'
require_relative 'display'

class HumanPlayer < Player 

    def initialize(name, color)
        super 
    end 

    def make_move(display) 
        display.move_cursor 
    end 

end 