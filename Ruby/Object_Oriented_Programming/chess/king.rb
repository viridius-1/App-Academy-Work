require_relative 'piece'
require_relative 'stepable'

class King < Piece  

    include Stepable

    def initialize(color, symbol, position, board)
        super 
    end 

    private 

    def move_dirs
        king_dirs
    end 

end 