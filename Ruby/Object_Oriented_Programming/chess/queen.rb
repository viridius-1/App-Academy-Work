require_relative 'piece'
require_relative 'slideable'

class Queen < Piece 
    
    include Slideable 

    def initialize(color, symbol, position, board)
        super 
    end 
    
    def move_dirs
        [:diagonal, :horizontal, :vertical]
    end 

end 