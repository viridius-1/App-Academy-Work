require_relative 'piece'
require_relative 'stepable'

class King < Piece  

    include Stepable

    def initialize(color, symbol, position, board)
        super 
    end 

    def moves 
        legal_moves = []
        move_dirs.each { |square| legal_moves << square if !board.any_pieces_attacking?(square, opponent_color) } 
        legal_moves
    end 

    private 

    def move_dirs
        king_dirs
    end 

end 