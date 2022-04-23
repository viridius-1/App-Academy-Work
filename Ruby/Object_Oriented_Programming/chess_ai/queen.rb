require_relative 'piece'
require_relative 'slideable'

class Queen < Piece 
    
    include Slideable 

    def initialize(color, symbol, position, board)
        super 
    end 
    
    private 

    def move_dirs
        horizontal_dirs + vertical_dirs + diagonal_dirs
    end 

end 