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

    def get_row_col(position)
        [position.first, position.last]
    end 

    def opponent_color
        if self.color == :white 
            :black 
        else 
            :white 
        end 
    end 

    def square_has_same_color_piece?(row, col)
        self.color == board[row, col].color 
    end 

    def square_has_different_color_piece?(row, col, opponent_color)
        opponent_color == board[row, col].color 
    end 

    def valid_position?(position)
        position.all? { |i| (0..7).include?(i) }
    end 

    def square_occupied?(position)
        board[position.first, position.last].class != NullPiece
    end 

    def position=(new_position)
        @position = new_position
    end 

    def [](row, col)
        board[row][col]
    end 

    def moves 
        all_moves = []
        move_dirs.each { |move_dir| all_moves += move_dir }
        all_moves 
    end 

end 