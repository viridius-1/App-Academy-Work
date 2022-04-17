require 'byebug'

module Slideable 

    def get_row_col(position)
        [position.first, position.last]
    end 

    def square_has_same_color_piece?(row, col)
        self.color == board[row, col].color 
    end 

    def square_has_different_color_piece?(row, col, opponent_color)
        opponent_color == board[row, col].color 
    end 

    def opponent_color
        if self.color == :white 
            :black 
        else 
            :white 
        end 
    end 

    def diagonal_dirs 

    end 
    
    def horizontal_dirs 
        horizontal_moves = []
        row, column = get_row_col(position)

        #get moves to the left 
        (column - 1).downto(0) do |col| 
            if square_has_same_color_piece?(row, col)
                break 
            elsif square_has_different_color_piece?(row, col, opponent_color)
                horizontal_moves << [row, col] 
                break 
            else 
                horizontal_moves << [row, col]  
            end 
        end 

        #get moves to the right 
        (column + 1).upto(7) do |col| 
            if square_has_same_color_piece?(row, col)
                break 
            elsif square_has_different_color_piece?(row, col, opponent_color)
                horizontal_moves << [row, col] 
                break 
            else 
                horizontal_moves << [row, col]  
            end 
        end 

        horizontal_moves
    end 

    def vertical_dirs
        vertical_moves = []
        row, column = get_row_col(position)

        #get moves up 
        (row - 1).downto(0) do |row_idx| 
            if square_has_same_color_piece?(row_idx, column)
                break 
            elsif square_has_different_color_piece?(row_idx, column, opponent_color)
                vertical_moves << [row_idx, column] 
                break 
            else 
                vertical_moves << [row_idx, column]  
            end 
        end 

        #get moves down 
        (row + 1).upto(7) do |row_idx| 
            if square_has_same_color_piece?(row_idx, column)
                break 
            elsif square_has_different_color_piece?(row_idx, column, opponent_color)
                vertical_moves << [row_idx, column] 
                break 
            else 
                vertical_moves << [row_idx, column]  
            end 
        end 
            
        vertical_moves
    end 

    def moves 
        all_moves = []
        move_dirs.each { |move_dir| all_moves += move_dir }
        all_moves 
    end 

    def grow_unblocked_moves_in_dir(dx, dy)
    end 

end 