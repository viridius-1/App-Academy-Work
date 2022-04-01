class Board 

    attr_reader :grid 

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, '_') }
    end 

    def valid?(position)
        position.all? { |i| i >= 0 && i < @grid.length }     
    end 

    def empty?(position)
        @grid[position.first][position.last] == '_'
    end 

    #method places mark at the position if the position is valid and empty 
    def place_mark(position, mark)
        if valid?(position) && empty?(position) 
            @grid[position.first][position.last] = mark 
        else    
            raise "ERROR - Invalid entry." 
        end 
    end 

    def print_board
        @grid.each do |row|
            row.each { |pos| print "#{pos} " } 
            puts 
        end 
    end 

    def win_row?(mark)
        @grid.each do |row| 
            return true if row.all? { |pos| pos == mark } 
        end
        false 
    end 

    def win_col?(mark)
        col_idx = 0 
        while col_idx < @grid.length 

            row_idx = 0 
            col_arr = []
            while row_idx < @grid.length 
                col_arr << @grid[row_idx][col_idx]
                row_idx += 1 
            end 

            return true if col_arr.all? { |el| el == mark }
            col_idx += 1 
        end 

        false 
    end 

    def win_diagonal?(mark)
        #check left to right 
        idx = 0 
        ltor_arr = []
        while idx < @grid.length 
            ltor_arr << @grid[idx][idx]
            idx += 1 
        end 
        return true if ltor_arr.all? { |el| el == mark } 

        #check right to left 
        row_idx = 0 
        col_idx = @grid.length - 1 
        rtol_arr = []
        while row_idx < @grid.length 
            rtol_arr << @grid[row_idx][col_idx]  
            row_idx += 1 
            col_idx -= 1 
        end 
        return true if rtol_arr.all? {|el| el == mark }

        false 
    end 

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark) 
    end 

    #returns boolean of whether there is at least 1 empty position on the board 
    def empty_positions? 
        @grid.each do |row| 
            row.each { |pos| return true if pos == '_' } 
        end 
        false 
    end 

end 