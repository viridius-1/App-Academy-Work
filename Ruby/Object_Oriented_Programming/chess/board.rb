require_relative 'piece'
require_relative 'null_piece'

class Board 

    attr_accessor :rows 

    def initialize 
        @rows = Array.new(8) { Array.new(8) }
        set_pieces(:white)
        set_pieces(:black)
    end 

    def [](row, col)
        rows[row][col]
    end 

    def []=(row, col, value)
        @rows[row][col] = value
    end 

    def switch_color(color)
        if :white 
            :black 
        else 
            :white 
        end 
    end 

    def set_piece(color, symbol, position)
        self[position.first, position.last] = Piece.new(color, symbol, position, self)
    end 

    def set_pieces(color)
        #set rooks 
        if color == :white 
            set_piece(:white, 'R', [7, 0])
            set_piece(:white, 'R', [7, 7])
        else 
            set_piece(:black, 'R', [0, 0])
            set_piece(:black, 'R', [0, 7])
        end 
    end 

end 