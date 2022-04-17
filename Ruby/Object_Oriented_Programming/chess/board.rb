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

    attr_accessor :rows 

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

    def move_piece_from_startposition_to_endposition(start_pos, end_pos)
        self[end_pos.first, end_pos.last] = self[start_pos.first, start_pos.last]
    end 

    def make_position_nullpiece(start_pos)
        self[start_pos.first, start_pos.last] = null_piece
    end 

    def update_piece_position(position)
        self[position.first, position.last].position = position
    end 

    def move_piece(start_pos, end_pos)  
        if piece_at_position?(start_pos)
            unless end_position_has_same_color_piece?(start_pos, end_pos)
                if valid_position?(end_pos)
                    move_piece_from_startposition_to_endposition(start_pos, end_pos)
                    make_position_nullpiece(start_pos)
                    update_piece_position(end_pos)
                else 
                    raise "That end position is not on the chess board."
                end 
            else 
                raise "The end position has a piece of the same color as the piece at the start position. The piece can't be moved there."
            end 
        else 
            raise "There is no piece at that start position."
        end   
    end 

    private 

    attr_reader :null_piece

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

    def piece_color(position) 
        self[position.first, position.last].color 
    end 

    def valid_position?(position)
        position.all? { |i| (0..7).include?(i) }
    end 

    def piece_at_position?(position)
        self[position.first, position.last] != null_piece 
    end 

    def end_position_has_same_color_piece?(start_pos, end_pos)
        piece_color(start_pos) == piece_color(end_pos) 
    end 

end 