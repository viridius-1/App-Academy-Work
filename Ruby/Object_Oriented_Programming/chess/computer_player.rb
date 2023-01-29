require_relative 'player'
require 'byebug'

class ComputerPlayer < Player 

    attr_reader :at_start, :black_positions, :board, :captured_piece, :continue, :end_pos, :piece, :pieces_with_valid_moves, :player_positions, :pieces_with_valid_moves_including_a_player_position, :player_pieces_with_valid_moves, :player_pieces_with_valid_moves_including_a_black_position, :precedence_hash

    def initialize(name, color, board)
        super(name, color)
        @board = board 
        @piece = nil 
        @end_pos = nil 
        @at_start = true 
        @precedence_hash = { 'Queen' => 1, 'Rook' => 2, 'Bishop' => 3, 'Knight' => 3, 'Pawn' => 4 }
    end 

    def move
        reset_data 
        checkmate_on_next_move?(:black, :white)
        #may want to put in a conditional for black to check white if possible...follow precedence 
        
        retreat_from_player_attack? if continue 

        take_player_piece? if continue 
        
        @piece, @end_pos = random_move if continue 

        start_pos = piece.position 
        make_move(piece, start_pos, end_pos) 
    end 

    private 

    def reset_data 
        @black_positions = []
        @player_positions = []

        @pieces_with_valid_moves = []
        @player_pieces_with_valid_moves = []

        @captured_piece = nil 
        @continue = true  
        @at_start = false 

        get_positions(@black_positions, :black)
        get_positions(@player_positions, :white)

        get_pieces_with_valid_moves(@pieces_with_valid_moves, :black)
        get_pieces_with_valid_moves(@player_pieces_with_valid_moves, :white)

        get_pieces_with_valid_moves_including_a_player_position
        get_player_pieces_with_valid_moves_including_a_black_position
    end 

    def precedence_score(piece)
        precedence_hash[piece.class.to_s]
    end 

    def get_positions(positions, color) 
        board.rows.each do |row| 
            row.each { |piece| positions << piece.position if piece.color == color } 
        end 
    end 

    def get_pieces_with_valid_moves(pieces, color)
        board.rows.each do |row|
            row.each { |piece| pieces << piece if piece.color == color && !piece.valid_moves.empty? } 
        end 
    end 

    def add_valid_moves_with_player_positions(piece)
        piece.valid_moves.each { |move| @pieces_with_valid_moves_including_a_player_position[piece] << move if player_positions.include?(move) } 
    end 

    def add_valid_moves_with_black_positions(piece)
        piece.valid_moves.each { |move| @player_pieces_with_valid_moves_including_a_black_position[piece] << move if black_positions.include?(move) }
    end 

    def reset_taking_pieces_black
        @pieces_with_valid_moves_including_a_player_position = Hash.new { |hash, key| hash[key] = [] }
    end 

    def reset_taking_pieces_player
        @player_pieces_with_valid_moves_including_a_black_position = Hash.new { |hash, key| hash[key] = [] }
    end 

    def get_pieces_with_valid_moves_including_a_player_position
        reset_taking_pieces_black
        pieces_with_valid_moves.each { |piece| add_valid_moves_with_player_positions(piece) } 
    end 

    def get_player_pieces_with_valid_moves_including_a_black_position
        reset_taking_pieces_player
        player_pieces_with_valid_moves.each { |piece| add_valid_moves_with_black_positions(piece) }
    end 

    def black_can_take_player_piece? 
        !pieces_with_valid_moves_including_a_player_position.empty?
    end 

    def player_can_take_black_piece? 
        !player_pieces_with_valid_moves_including_a_black_position.empty?         
    end 

    def positions_on_duplicate_board(board_copy, color)
        player_positions_on_duplicate_board = []

        board_copy.rows.each do |row| 
            row.each { |piece| player_positions_on_duplicate_board << piece.position if piece.color == color } 
        end 

        player_positions_on_duplicate_board
    end 

    def black_piece_take_white_piece_passes_precedence_test?(player_positions_on_duplicate_board, board_copy, black_move, black_piece_score)
        if player_positions_on_duplicate_board.include?(black_move) 
            white_piece = board_copy[black_move.first, black_move.last]
            white_piece_score = precedence_score(white_piece) 
            return true if white_piece_score <= black_piece_score
        end 
        false 
    end 

    def white_piece_take_black_piece_passes_precedence_test?(black_positions_on_duplicate_board, board_copy, white_move, white_piece, black_piece_score)
        if black_positions_on_duplicate_board.include?(white_move)
            white_piece_score = precedence_score(white_piece) 
            return false if white_piece_score > black_piece_score
        end 
        true 
    end 

    #method asseses whether to let player take a black piece. based on key-value pairs in precedence hash.
    def fair_player_attack?(player_piece, move)
        black_piece = board[move.first, move.last]
        black_piece_score = precedence_score(black_piece)

        board_copy = player_piece.make_move_on_duplicate_board(move)

        player_positions_on_duplicate_board = positions_on_duplicate_board(board_copy, :white)

        #assess whether a black piece can take a white piece with an equal or greater precedence than the black_piece_score
        board_copy.rows.each do |row| 
            row.each do |piece| 
                if piece.color == :black 
                    piece.valid_moves.each { |black_move| return true if black_piece_take_white_piece_passes_precedence_test?(player_positions_on_duplicate_board, board_copy, black_move, black_piece_score) } 
                end 
            end 
        end 

        false 
    end 

    #method asseses whether black should take a white piece. based on key-value pairs in precedence hash.
    def fair_black_attack?(black_piece, black_move)
        black_piece_score = precedence_score(black_piece)

        board_copy = black_piece.make_move_on_duplicate_board(black_move)

        black_positions_on_duplicate_board = positions_on_duplicate_board(board_copy, :black)

        board_copy.rows.each do |row| 
            row.each do |piece| 
                if piece.color == :white 
                    piece.valid_moves.each do |white_move| 
                        white_piece = piece 
                        return false if !white_piece_take_black_piece_passes_precedence_test?(black_positions_on_duplicate_board, board_copy, white_move, white_piece, black_piece_score)
                    end 
                end 
            end 
        end 

        true 
    end 

    def retreat?(position)
        black_piece = board[position.first, position.last]

        black_piece.valid_moves.each do |move| 
            if !board.any_pieces_attacking?(move, :white)
                set_move(black_piece, move)
                return true 
            end 
        end 

        false
    end 

    def retreat_from_player_attack?
        if player_can_take_black_piece?
            player_pieces_with_valid_moves_including_a_black_position.each do |player_piece, player_moves| 
                player_moves.each do |player_move| 
                    if !fair_player_attack?(player_piece, player_move)
                        return true if retreat?(player_move)
                    end 
                end 
            end 
        end 
        false 
    end 

    def checkmate_on_next_move?(attack_color, checkmate_color)
        board.rows.each do |row|
            row.each do |piece| 
                if piece.color == attack_color 
                    piece.valid_moves.each do |move|
                        if piece.move_into_checkmate?(move) 
                            set_move(piece, move)
                            return true 
                        end 
                    end 
                end 
            end 
        end 
        false 
    end 

    def random_move
        piece = pieces_with_valid_moves.sample 
        end_pos = piece.valid_moves.sample 
        [piece, end_pos]
    end 

    def get_black_take_player_hash
        black_take_player_hash = {}

        pieces_with_valid_moves_including_a_player_position.each do |piece, black_moves| 
            black_moves.each do |black_move|
                white_piece = board[black_move.first, black_move.last]
                black_take_player_hash[piece] = [precedence_score(white_piece), black_move] 
            end 
        end 

        black_take_player_hash
    end 

    def sort_by_white_piece_score(black_take_player_hash)
        black_take_player_hash.sort_by { |piece, move_data| move_data[0] }
    end 

    def valid_take_player_piece_move?(black_take_player_arr)
        black_take_player_arr.each do |move_data|
            black_piece = move_data[0]
            black_move = move_data[1][1]
            if fair_black_attack?(black_piece, black_move)
                set_move(black_piece, black_move)
                return true
            end 
        end 
        false 
    end 

    def take_player_piece?
        if black_can_take_player_piece?
            black_take_player_hash = get_black_take_player_hash 
            black_take_player_arr = sort_by_white_piece_score(black_take_player_hash)
            return true if valid_take_player_piece_move?(black_take_player_arr)
        end 
        false 
    end 

    def mark_captured_piece(piece, end_pos)
        @captured_piece = board[end_pos.first, end_pos.last].class if piece.opponent_color == board[end_pos.first, end_pos.last].color
    end 

    def set_move(piece, move)
        @piece = piece 
        @end_pos = move 
        @continue = false 
    end 

    def make_move(piece, start_pos, end_pos)
        mark_captured_piece(piece, end_pos)
        board.move_piece(start_pos, end_pos)
        [piece.class, start_pos, end_pos, captured_piece]
    end 

end 