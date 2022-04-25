require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece  

    include Slideable

    def initialize(color, symbol, position, board)
        super 
    end 

    private 

    def move_dirs
        diagonal_dirs
    end 

end 