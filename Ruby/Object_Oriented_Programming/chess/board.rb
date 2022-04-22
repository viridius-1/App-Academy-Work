require_relative 'piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'null_piece'
require 'byebug'

class Board 

    attr_accessor :null_piece, :rows 

    def self.valid_position?(position)
        position.all? { |i| (0..7).include?(i) }
    end 

    def initialize 
        @rows = Array.new(8) { Array.new(8) }
        @null_piece = NullPiece.instance
        set_null_pieces 
        set_pieces(:white)
        set_pieces(:black)
    end 

    def [](row, col)
        rows[row][col]
    end 

    def []=(row, col, value)
        @rows[row][col] = value
    end 

    def move_piece(color, start_pos, end_pos) 
        #if Board.valid_position?(start_pos)
            #if piece_at_position?(start_pos)
                #if Board.valid_position?(end_pos)
                    unless end_position_has_same_color_piece?(start_pos, end_pos)
                        if !move_results_in_check?(start_pos, end_pos)
                            if legal_move?(start_pos, end_pos)
                                if !move_to_king_position?(start_pos, end_pos)
                                    make_move(start_pos, end_pos)
                                else 
                                    puts "A piece can't move to the king's position."
                                    prompt_to_continue_move
                                end 
                            else 
                                puts "That is an illegal move."
                                prompt_to_continue_move
                            end 
                        else 
                            puts "This move can't be made, because it would result in check."
                            prompt_to_continue_move
                        end 
                    else 
                        puts "The end position has a piece of the same color as the piece at the start position. The piece can't be moved there."
                        prompt_to_continue_move
                    end 
        end 

    #             else 
    #                 puts "That end position is not on the chess board."
    #                 prompt_to_continue_move
    #             end 
    #         else 
    #             puts "There is no piece at that start position."
    #             prompt_to_continue_move
    #         end 
    #     else 
    #         puts "That start position is not on the chess board."
    #         prompt_to_continue_move
    #     end   
    # end 

    def correct_piece_color?(color, start_pos)
        color == piece_color(start_pos)
    end 

    def prompt_to_continue_move
        puts "Press return/enter to continue."
        gets 
        false 
    end 

    def move_piece!(start_pos, end_pos) 
        make_move(start_pos, end_pos)
    end 

    def null_piece?(row_idx, col_idx)
        self[row_idx, col_idx].class == NullPiece
    end 

    def find_king(color)
        rows.each_with_index do |row, row_idx| 
            row.each_with_index { |piece, col_idx| return piece if king?(row_idx, col_idx, color) } 
        end 
    end 

    def any_pieces_attacking?(position, color) 
        rows.each do |row|  
            row.each { |piece| return true if piece_attacking_position?(piece, position, color) } 
        end 
        false 
    end 

    def in_check?(color)
        king = find_king(color)
        king_position = king.position 
        any_pieces_attacking?(king_position, king.opponent_color)
    end 

    def checkmate?(color)
        rows.each do |row|
            row.each do |piece| 
                if piece.color == color 
                    return false if !piece.valid_moves.empty? 
                end 
            end  
        end 
        true 
    end 

    def duplicate 
        board_copy = Board.new 
        board_copy.null_piece = null_piece
        board_copy.rows = copy_rows
    
        #update each piece to reference board copy
        board_copy.rows.each do |row| 
            row.each { |piece| piece.board = board_copy } 
        end 

        board_copy
    end

    private 

    def set_null_pieces
        (2..5).each do |row| 
            (0..7).each { |col| self[row, col] = null_piece } 
        end 
    end 

    #method translates chess piece unicode into a chess icon 
    def unicode(code) 
        code.encode('utf-8')
    end 

    def set_pieces(color)
        #unicode for chess pieces 
        white_king = "\u2654"
        white_queen = "\u2655"
        white_rook = "\u2656"
        white_bishop = "\u2657"
        white_knight = "\u2658"
        white_pawn = "\u2659"
        black_king = "\u265A"
        black_queen = "\u265B"
        black_rook = "\u265C"
        black_bishop = "\u265D"
        black_knight = "\u265E"
        black_pawn = "\u265F"

        #set rooks 
        if color == :white 
            self[7, 0] = Rook.new(:white, unicode(white_rook), [7, 0], self)
            self[7, 7] = Rook.new(:white, unicode(white_rook), [7, 7], self)
        else 
            self[0, 0] = Rook.new(:black, unicode(black_rook), [0, 0], self)
            self[0, 7] = Rook.new(:black, unicode(black_rook), [0, 7], self)
        end 

        #set knights 
        if color == :white 
            self[7, 1] = Knight.new(:white, unicode(white_knight), [7, 1], self)
            self[7, 6] = Knight.new(:white, unicode(white_knight), [7, 6], self)
        else 
            self[0, 1] = Knight.new(:black, unicode(black_knight), [0, 1], self)
            self[0, 6] = Knight.new(:black, unicode(black_knight), [0, 6], self)
        end 

        #set bishops 
        if color == :white 
            self[7, 2] = Bishop.new(:white, unicode(white_bishop), [7, 2], self)
            self[7, 5] = Bishop.new(:white, unicode(white_bishop), [7, 5], self)
        else 
            self[0, 2] = Bishop.new(:black, unicode(black_bishop), [0, 2], self)
            self[0, 5] = Bishop.new(:black, unicode(black_bishop), [0, 5], self)
        end 

        #set queen 
        if color == :white 
            self[7, 3] = Queen.new(:white, unicode(white_queen), [7, 3], self)
        else 
            self[0, 3] = Queen.new(:black, unicode(black_queen), [0, 3], self)
        end 

        #set king 
        if color == :white 
            self[7, 4] = King.new(:white, unicode(white_king), [7, 4], self)
        else 
            self[0, 4] = King.new(:black, unicode(black_king), [0, 4], self)
        end 

        #set pawns 
        if color == :white 
            (0..7).each { |col| self[6, col] = Pawn.new(:white, unicode(white_pawn), [6, col], self) }  
        else 
            (0..7).each { |col| self[1, col] = Pawn.new(:black, unicode(black_pawn), [1, col], self) }  
        end 
    end 

    def copy_rows
        copy_of_rows = []

        rows.each do |row| 
            individual_row = []
            row.each do |piece| 
                if piece.class != NullPiece 
                    individual_row << piece.dup 
                else 
                    individual_row << piece 
                end 
            end 
            copy_of_rows << individual_row  
        end 

        copy_of_rows
    end 

    def piece_color(position) 
        self[position.first, position.last].color 
    end 

    def piece_at_position?(position)
        self[position.first, position.last] != null_piece 
    end 

    def piece_attacking_position?(piece, position, color)
        if ![King, NullPiece].include?(piece.class) && piece.color == color 
            return true if piece.moves.include?(position) 
        end 
    end 

    def end_position_has_same_color_piece?(start_pos, end_pos)
        piece_color(start_pos) == piece_color(end_pos) 
    end 

    def move_piece_from_startposition_to_endposition(start_pos, end_pos)
        self[end_pos.first, end_pos.last] = self[start_pos.first, start_pos.last]
    end 

    def make_position_nullpiece(start_pos)
        self[start_pos.first, start_pos.last] = null_piece
    end 

    def update_piece_position(position)
        self[position.first, position.last].position = position
    end 

    def make_move(start_pos, end_pos)
        move_piece_from_startposition_to_endposition(start_pos, end_pos)
        make_position_nullpiece(start_pos)
        update_piece_position(end_pos)
    end 

    def move_results_in_check?(start_pos, end_pos)
        self[start_pos.first, start_pos.last].move_into_check?(end_pos) && self[start_pos.first, start_pos.last].moves.include?(end_pos)
    end 

    def king?(row, col, color)
        self[row, col].color == color && self[row, col].class == King
    end 

    def move_to_king_position?(start_pos, end_pos)
        self[start_pos.first, start_pos.last].get_opponent_king_position == end_pos
    end 

    def legal_move?(start_pos, end_pos)
        if self[start_pos.first, start_pos.last].valid_moves.include?(end_pos)
            true 
        else 
            false 
        end 
    end 

end 

