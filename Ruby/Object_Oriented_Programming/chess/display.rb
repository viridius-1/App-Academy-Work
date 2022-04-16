require_relative 'board'

class Display 

    attr_reader :board

    def initialize
        @board = Board.new 
    end 

    def render 
        chess_board = []

        #build 2D array of chess piece symbols 
        board.rows.each_with_index do |row, row_idx| 
            chess_row = []
            row.each_with_index { |col, col_idx| chess_row << board[row_idx, col_idx].symbol } 
            chess_board << chess_row
        end 

        draw_board(chess_board) 
    end 

    def draw_board(args, boxlen=3)
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
                    draw << start + (topbot*boxlen)
                    colindex == row.length - 1 ? draw << tr : ""
                end
            end
            draw << "\n" if rowindex == 0

            # MIDDLE OF ROW: DATA
            row.each_with_index do |col, index|
                if index == 0 
                    draw << board_row_idx 
                end 
                draw << side + col.to_s.center(boxlen)
            end
            draw << side + "\n"

            # END OF ROW
            row.each_with_index do |col, colindex|
                if colindex == 0
                    rowindex == args.length - 1 ? draw << bl : draw << lc
                    draw << (topbot*boxlen)
                else
                    rowindex == args.length - 1 ? draw << bc : draw << crs
                    draw << (topbot*boxlen)
                end
                endchar = rowindex == args.length - 1 ? br : rc

                #Overhang elimination if the next row is shorter
                if args[rowindex+1]
                    if args[rowindex+1].length < args[rowindex].length
                    endchar = br
                    end
                end
                colindex == row.length - 1 ? draw << endchar : ""
            end

            draw << "\n"
            board_row_idx += 1 
        end

        puts "CHESS BOARD\n".rjust(24)
        (0..7).each { |i| print "   #{i}" } 
        puts "\n"
        draw.each { |char| print "#{char}" } 

        true
    end 

end 