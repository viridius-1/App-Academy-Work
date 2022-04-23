require_relative 'player'
require 'byebug'

class ComputerPlayer < Player 

    attr_reader :at_start, :board 

    def initialize(name, color, board)
        super(name, color)
        @board = board 
        @at_start = true 
    end 

    def get_all_pieces_with_valid_moves
        pieces_with_valid_moves = []

        board.rows.each do |row|
            row.each { |piece| pieces_with_valid_moves << piece if piece.color == color && !piece.valid_moves.empty? } 
        end 

        pieces_with_valid_moves
    end 

    def make_move(piece)
        start_pos = piece.position 
        end_pos = piece.valid_moves.sample
        board.move_piece(start_pos, end_pos)
        [piece.class, start_pos, end_pos]
    end 

    def move
        @at_start = false 
        all_pieces_with_moves = get_all_pieces_with_valid_moves
        make_move(all_pieces_with_moves.sample) 
    end 

end 