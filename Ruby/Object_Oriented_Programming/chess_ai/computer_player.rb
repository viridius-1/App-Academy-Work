require_relative 'player'
require 'byebug'

class ComputerPlayer < Player 

    attr_reader :at_start, :board, :pieces_with_valid_moves, :pieces_with_valid_moves_including_a_player_position

    def initialize(name, color, board)
        super(name, color)
        @board = board 
        @at_start = true 
        @pieces_with_valid_moves = []
        @pieces_with_valid_moves_including_a_player_position = []
    end 

    def get_pieces_with_valid_moves
        @pieces_with_valid_moves = []
        board.rows.each do |row|
            row.each { |piece| @pieces_with_valid_moves << piece if piece.color == color && !piece.valid_moves.empty? } 
        end 
    end 

    def get_pieces_with_valid_moves_including_a_player_position
        #player_color = 

    end 

    def make_move(piece)
        start_pos = piece.position 
        end_pos = piece.valid_moves.sample
        board.move_piece(start_pos, end_pos)
        [piece.class, start_pos, end_pos]
    end 


    #get all pieces with valid moves
    #get pieces with valid moves where the move includes a white position 
    #if any pieces with valid moves include a white position 
        #make a move that takes a white piece
    #else 
        #make random move 
    #end 

    def move
        @at_start = false 
        get_pieces_with_valid_moves
        get_pieces_with_valid_moves_including_a_player_position
        make_move(pieces_with_valid_moves.sample) 
    end 

end 