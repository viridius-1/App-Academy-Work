require_relative 'slideable'

class Piece 

    include Slideable

    attr_reader :color, :board, :symbol
    attr_accessor :position

    def initialize(color, symbol, position, board)
        @color = color
        @symbol = symbol 
        @position = position
        @board = board 
    end 

    def position=(new_position)
        @position = new_position
    end 

    def [](row, col)
        board[row][col]
    end 

end 