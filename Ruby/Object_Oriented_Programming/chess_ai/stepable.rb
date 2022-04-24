require_relative 'board'
require 'byebug'

module Stepable 

    private 

    #method returns moves a king can make 
    def king_dirs
        king_moves = []
        row, column = get_row_col(position) 
        column_start, column_end = get_column_coordinates(column)

        #get moves up 
        row_idx = row - 1 
        if row_on_board?(row_idx)
            (column_start).upto(column_end) do |col_idx| 
                if square_has_same_color_piece?(row_idx, col_idx) 
                    next 
                else 
                    king_moves << [row_idx, col_idx]  
                end
            end 
        end 

        #get side moves 
        row_idx = row  
        (column_start).upto(column_end) do |col_idx| 
            next if col_idx == column
            if square_has_same_color_piece?(row_idx, col_idx) 
                next 
            else 
                king_moves << [row_idx, col_idx]  
            end
        end 

        #get moves down 
        row_idx = row + 1 
        if row_on_board?(row_idx)
            (column_start).upto(column_end) do |col_idx| 
                if square_has_same_color_piece?(row_idx, col_idx) 
                    next 
                else 
                    king_moves << [row_idx, col_idx]  
                end
            end 
        end 

        king_moves
    end 

    #method returns moves a knight can make 
    def knight_dirs 
        knight_moves = []
        row, column = get_row_col(position)

        #get move up and to the left  
        row_idx = row - 2 
        col_idx = column - 1 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move up and to the right 
        row_idx = row - 2 
        col_idx = column + 1 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move to the right and up 
        row_idx = row - 1 
        col_idx = column + 2 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move to the right and down 
        row_idx = row + 1 
        col_idx = column + 2 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end

        #get move down and to the right 
        row_idx = row + 2 
        col_idx = column + 1 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move down and to the left 
        row_idx = row + 2 
        col_idx = column - 1 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move to the left and down 
        row_idx = row + 1 
        col_idx = column - 2 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        #get move to the left and up 
        row_idx = row - 1 
        col_idx = column - 2 
        if Board.valid_position?([row_idx, col_idx])
            knight_moves << [row_idx, col_idx] unless square_has_same_color_piece?(row_idx, col_idx)
        end 

        knight_moves
    end 

end 