require_relative 'piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
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

    def set_pieces(color)
        #set rooks 
        if color == :white 
            self[7, 0] = Rook.new(:white, 'R', [7, 0], self)
            self[7, 7] = Rook.new(:white, 'R', [7, 7], self)
        else 
            self[0, 0] = Rook.new(:black, 'R', [0, 0], self)
            self[0, 7] = Rook.new(:black, 'R', [0, 7], self)
        end 

        #set knights 
        if color == :white 
            self[7, 1] = Knight.new(:white, 'Kn', [7, 1], self)
            self[7, 6] = Knight.new(:white, 'Kn', [7, 6], self)
        else 
            self[0, 1] = Knight.new(:black, 'Kn', [0, 1], self)
            self[0, 6] = Knight.new(:black, 'Kn', [0, 6], self)
        end 

        #set bishops 
        if color == :white 
            self[7, 2] = Bishop.new(:white, 'B', [7, 2], self)
            self[7, 5] = Bishop.new(:white, 'B', [7, 5], self)
        else 
            self[0, 2] = Bishop.new(:black, 'B', [0, 2], self)
            self[0, 5] = Bishop.new(:black, 'B', [0, 5], self)
        end 

        #set queen 
        if color == :white 
            self[7, 3] = Queen.new(:white, 'Q', [7, 3], self)
        else 
            self[0, 3] = Queen.new(:black, 'Q', [0, 3], self)
        end 

        #set king 
        if color == :white 
            self[7, 4] = King.new(:white, 'K', [7, 4], self)
        else 
            self[0, 4] = King.new(:black, 'K', [0, 4], self)
        end 

        #set pawns 
        if color == :white 
            (0..7).each { |col| self[6, col] = Pawn.new(:white, 'p', [6, col], self) }  
        else 
            (0..7).each { |col| self[1, col] = Pawn.new(:black, 'p', [1, col], self) }  
        end 

    end 

end 