require_relative 'slideable'
require 'byebug'

class Piece 

    attr_reader :board, :color, :position, :symbol 
    
    def initialize(color, symbol, position, board)
        @color = color
        @symbol = symbol 
        @position = position
        @board = board 
    end 

    def [](row, col)
        board[row][col]
    end 

    def position=(new_position)
        @position = new_position
    end 

    def opponent_color
        if color == :white 
            :black 
        else 
            :white 
        end 
    end 

    def moves 
        all_moves = []
        move_dirs.each { |move_dir| all_moves += move_dir }
        all_moves
    end 

    private 

    def get_row_col(position)
        [position.first, position.last]
    end 

    def square_has_same_color_piece?(row, col)
        self.color == board[row, col].color 
    end 

    def square_has_different_color_piece?(row, col, opponent_color)
        opponent_color == board[row, col].color 
    end 

    def square_occupied?(position)
        board[position.first, position.last].class != NullPiece
    end 

end 