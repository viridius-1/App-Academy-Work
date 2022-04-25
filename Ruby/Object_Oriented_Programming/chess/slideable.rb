require_relative 'board'
require 'byebug'

module Slideable 

    private 

    def diagonal_dirs
        diagonal_moves = [] 
        row, column = get_row_col(position) 

        #get moves up and to the right
        row_idx = row 
        (column + 1).upto(7) do |col_idx| 
            row_idx -= 1 
            break unless Board.valid_position?([row_idx, col_idx]) 
            if square_has_same_color_piece?(row_idx, col_idx)
                break 
            elsif square_has_different_color_piece?(row_idx, col_idx, opponent_color)
                diagonal_moves << [row_idx, col_idx] 
                break 
            else 
                diagonal_moves << [row_idx, col_idx]  
            end  
        end 

        #get moves down and to the right 
        col_idx = column
        (row + 1).upto(7) do |row_idx| 
            col_idx += 1 
            break unless Board.valid_position?([row_idx, col_idx]) 
            if square_has_same_color_piece?(row_idx, col_idx)
                break 
            elsif square_has_different_color_piece?(row_idx, col_idx, opponent_color)
                diagonal_moves << [row_idx, col_idx] 
                break 
            else 
                diagonal_moves << [row_idx, col_idx]  
            end 
        end 

        #get moves down and to the left 
        col_idx = column
        (row + 1).upto(7) do |row_idx| 
            col_idx -= 1 
            break unless Board.valid_position?([row_idx, col_idx]) 
            if square_has_same_color_piece?(row_idx, col_idx)
                break 
            elsif square_has_different_color_piece?(row_idx, col_idx, opponent_color)
                diagonal_moves << [row_idx, col_idx] 
                break 
            else 
                diagonal_moves << [row_idx, col_idx]  
            end 
        end 

        #get moves up and to the left 
        row_idx = row 
        (column - 1).downto(0) do |col_idx| 
            row_idx -= 1 
            break unless Board.valid_position?([row_idx, col_idx]) 
            if square_has_same_color_piece?(row_idx, col_idx)
                break 
            elsif square_has_different_color_piece?(row_idx, col_idx, opponent_color)
                diagonal_moves << [row_idx, col_idx] 
                break 
            else 
                diagonal_moves << [row_idx, col_idx]  
            end
        end  

        diagonal_moves 
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

end 