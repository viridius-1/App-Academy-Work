class Piece 

    attr_reader :color, :symbol

    def initialize(color, symbol, position, board)
        @color = color
        @symbol = symbol 
        @position = position
        @board = board 
    end 

end 