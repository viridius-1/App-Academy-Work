require_relative "tile.rb"
require 'colorize'

class Board 

    attr_reader :grid 

    #method creates a grid of tiles from a text file 
    def self.from_file(file)
        tiles = []
        file_arr = File.readlines("#{file}") 
        file_arr.each do |row| 
            sub_arr = []
            row.each_char do |space| 
                if space == "0" 
                    sub_arr << Tile.new(space, false)
                elsif space != "0" && space != "\n" 
                    sub_arr << Tile.new(space, true)
                end 
            end
            tiles << sub_arr
        end 
        Board.new(tiles)
    end 

    #method accepts a grid of tiles 
    def initialize(grid)
        @grid = grid 
    end 

    #method changes the tile to a new value if the tile's @given is false. So basically, it changes the tile on the board if permitted.  
    def []=(position, new_value)
        if @grid[position.first][position.last].given == false 
            @grid[position.first][position.last].value = new_value 
        else 
            @grid[position.first][position.last].no_change_msg
        end 
    end 

    #method returns the tile specified by position 
    def [](position)
        @grid[position.first][position.last]
    end 

    #method renders an ASCII grid based on a 2D array. Used source code and modified it.  
    #Source: https://codereview.stackexchange.com/questions/201159/drawing-an-ascii-grid-in-ruby-based-on-a-2d-array 
    def drawgrid(args, boxlen=3)
        #Define box drawing characters
        side = '│'
        topbot = '─'
        tl = ' ┌'
        tr = '┐'
        bl = ' └'
        br = '┘'
        lc = ' ├'
        rc = '┤'
        tc = '┬'
        bc = '┴'
        crs = '┼'
        ##############################
        board_row_idx = 0 
        draw = []
    
        args.each_with_index do |row, rowindex|
            # TOP OF ROW Upper borders
            row.each_with_index do |col, colindex|
                if rowindex == 0
                    colindex == 0 ? start = tl : start = tc
                    draw << start.colorize(:blue) + (topbot.colorize(:blue)*boxlen)
                    colindex == row.length - 1 ? draw << tr.colorize(:blue) : ""
                end 
            end
            draw << "\n" if rowindex == 0

            # MIDDLE OF ROW: DATA
            row.each_with_index do |col, index|
            if ((board_row_idx % 9 == 0 && board_row_idx >= 9) || board_row_idx == 0) && index == 0 
                draw << "#{board_row_idx / 9}" 
            end 
            if board_row_idx == 0 || board_row_idx % 3 == 0
                draw << side.colorize(:blue) + col.to_s.center(boxlen)
            else 
                draw << side + col.to_s.center(boxlen)
            end 
            board_row_idx += 1 
            end
            draw << side.colorize(:blue) + "\n"    

            # END OF ROW
            row.each_with_index do |col, colindex|
                if colindex == 0
                    rowindex == args.length - 1 ? draw << bl.colorize(:blue) : draw << lc.colorize(:blue)
                    if rowindex == 2 || rowindex == 5 || rowindex == 8  
                    draw << (topbot.colorize(:blue)*boxlen)
                    else 
                    draw << (topbot*boxlen)
                    end 
                else 
                    rowindex == args.length - 1 ? draw << bc.colorize(:blue) : 
                    if rowindex == 2 || rowindex == 5 || rowindex == 8 || colindex == 3 || colindex == 6
                    draw << crs.colorize(:blue)
                    else 
                    draw << crs
                    end
                    if rowindex == 2 || rowindex == 5 || rowindex == 8  
                    draw << (topbot.colorize(:blue)*boxlen)
                    else 
                    draw << (topbot*boxlen)
                    end 
                end 
                endchar = rowindex == args.length - 1 ? br.colorize(:blue) : rc.colorize(:blue)

                #Overhang elimination if the next row is shorter
                if args[rowindex+1]
                    if args[rowindex+1].length < args[rowindex].length
                    endchar = br
                    end
                end
                colindex == row.length - 1 ? draw << endchar : ""
            end

            draw << "\n"
        end

        puts "SUDOKU BOARD\n".rjust(25)
        (0...9).each { |i| print "   #{i}" } 
        puts "\n"
        draw.each do |char|
        print "#{char}"
        end

        true
    end 

    #method prints the board 
    def render 
        sudoku_board = []

        @grid.each do |row| 
            sub_arr = []
            row.each do |tile| 
                if tile.given 
                    sub_arr << tile.value
                else 
                    sub_arr << " #{tile.value.colorize(:red)} "
                end   
            end  
            sudoku_board << sub_arr 
        end 

        drawgrid(sudoku_board)
    end 

    def solved? 
        rows_solved? && columns_solved? && subgrids_solved? 
    end 

    def correct_values
        ("1".."9").to_a
    end 

    def rows_solved? 
        @grid.each do |row| 
            sub_arr = []
            row.each { |tile| sub_arr << tile.value }
            return false if sub_arr.sort != correct_values 
        end 
        true 
    end 

    def columns_solved? 
        col_idx = 0 
        while col_idx < @grid.length 
            sub_arr = []
            row_idx = 0 
            while row_idx < @grid.length 
                sub_arr << self[[row_idx, col_idx]].value 
                row_idx += 1 
            end 
            return false if sub_arr.sort != correct_values
            col_idx += 1 
        end 
        true 
    end 

    def subgrids_solved? 
        subgrid_solved?([0, 0], [2, 2]) && subgrid_solved?([0, 3], [2, 5]) && subgrid_solved?([0, 6], [2, 8]) && subgrid_solved?([3, 0], [5, 2]) && subgrid_solved?([3, 3], [5, 5]) && subgrid_solved?([3, 6], [5, 8]) && subgrid_solved?([6, 0], [8, 2]) && subgrid_solved?([6, 3], [8, 5]) && subgrid_solved?([6, 6], [8, 8])
    end 

    def subgrid_solved?(start_pos, end_pos)
        sub_arr = []
        col_idx = start_pos.last 
        while col_idx <= end_pos.last 
            row_idx = start_pos.first 
            while row_idx <= end_pos.first 
                sub_arr << self[[row_idx, col_idx]].value 
                row_idx += 1 
            end 
            col_idx += 1 
        end 
        sub_arr.sort == correct_values    
    end 

end 