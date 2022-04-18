require_relative 'board'

module Stepable 

    private 

    def row_on_board?(row)
        (0..7).include?(row)
    end 

    #method returns moves a king can make 
    def king_dirs 
        king_moves = []

        #get moves up 
        row, column = get_row_col(position) 
        row -= 1 
        if row_on_board?(row)
            (column - 1).upto(column + 1) do |col_idx| 
                if square_has_same_color_piece?(row, col_idx)
                    next 
                else 
                    king_moves << [row, col_idx]  
                end
            end 
        end 

        #get side moves 
        row, column = get_row_col(position) 
        (column - 1).upto(column + 1) do |col_idx| 
            next if col_idx == column
            if square_has_same_color_piece?(row, col_idx)
                next 
            else 
                king_moves << [row, col_idx]  
            end
        end 

        #get moves down 
        row, column = get_row_col(position) 
        row += 1 
        if row_on_board?(row)
            (column - 1).upto(column + 1) do |col_idx| 
                if square_has_same_color_piece?(row, col_idx)
                    next 
                else 
                    king_moves << [row, col_idx]  
                end
            end 
        end 

        king_moves
    end 

    #method returns moves a knight can make 
    def knight_dirs 
        knight_moves = []

        #get move up and to the left 
        row, column = get_row_col(position) 
        row -= 2 
        column -= 1 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move up and to the right 
        row, column = get_row_col(position) 
        row -=2 
        column += 1 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move to the right and up 
        row, column = get_row_col(position) 
        row -= 1 
        column += 2 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move to the right and down 
        row, column = get_row_col(position) 
        row += 1 
        column += 2 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end

        #get move down and to the right 
        row, column = get_row_col(position) 
        row += 2 
        column += 1 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move down and to the left 
        row, column = get_row_col(position) 
        row += 2 
        column -= 1 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move to the left and down 
        row, column = get_row_col(position) 
        row += 1 
        column -= 2 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        #get move to the left and up 
        row, column = get_row_col(position) 
        row -= 1 
        column -=2 
        if Board.valid_position?([row, column])
            knight_moves << [row, column] unless square_has_same_color_piece?(row, column)
        end 

        knight_moves
    end 

end 