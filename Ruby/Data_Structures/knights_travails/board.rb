class Board 

    attr_accessor :board 

    def initialize(board_size) 
        @board = Array.new(8) { Array.new(8) }
    end 
    
end 