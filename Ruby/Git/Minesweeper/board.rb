require_relative "tile.rb"
require 'colorize'

class Board 

    attr_accessor :start_time, :total_time
    attr_reader :board_size

    #initialize each tile on the board 
    def initialize(board, board_size)
        row_idx = -1  
        @board = board.map do |row| 
            row_idx += 1 
            col_idx = -1  
            row.map do |tile| 
                col_idx += 1 
                Tile.new(row_idx, col_idx)
            end 
        end  
        @board_size = board_size 
        set_start_time
        @total_time = 0  
    end 

    def get_neighbors 
        board.each do |row| 
            row.each do |tile| 
                tile_row = tile.position[0] 
                tile_col = tile.position[1] 

                #get neighbors above tile 
                row_above_tile = tile_row - 1 
                col_above_tile = tile_col - 1 
                3.times do 
                    tile.neighbors << [row_above_tile, col_above_tile] if valid_neighbor?(row_above_tile, col_above_tile)
                    col_above_tile += 1 
                end 

                #get neighbors beside tile 
                row_beside_tile = tile_row 
                col_beside_tile = tile_col - 1 
                2.times do 
                    tile.neighbors << [row_beside_tile, col_beside_tile] if valid_neighbor?(row_beside_tile, col_beside_tile)
                    col_beside_tile += 2 
                end 

                #get neighbors below tile 
                row_below_tile = tile_row + 1 
                col_below_tile = tile_col - 1 
                3.times do 
                    tile.neighbors << [row_below_tile, col_below_tile] if valid_neighbor?(row_below_tile, col_below_tile) 
                    col_below_tile += 1 
                end 
            end 
        end 
    end 

    def get_all_positions
        all_positions = []
        board.each do |row| 
            row.each { |tile| all_positions << tile.position } 
        end 
        all_positions
    end 

    def set_bombs
        all_positions = get_all_positions 
        bomb_ct = 0 
        bombs_to_be_set = ((board_size ** 2) / board_size) + 1 
        until bomb_ct == bombs_to_be_set 
            selected_position = all_positions.sample 
            unless position_has_bomb?(selected_position)
                set_bomb(selected_position)
                bomb_ct += 1 
            end 
        end 
    end 

    def position_has_bomb?(position)
        self[position.first, position.last].has_bomb
    end 

    def position_flagged?(position)
        self[position.first, position.last].flagged
    end 

    def set_bomb(position) 
        self[position.first, position.last].has_bomb = true 
    end 

    #method calculates the surrounding bombs for every tile 
    def calculate_surrounding_bombs
        board.each do |row| 
            row.each do |tile| 
                bombs = 0 
                tile.neighbors.each do |neighbor| 
                    tile_neighbor = self[neighbor.first, neighbor.last]
                    bombs += 1 if tile_neighbor.has_bomb
                end 
                tile.surrounding_bombs = bombs
            end 
        end 
    end 

    #method uses syntactic sugar to call a tile in the board 
    def [](row, col)
        board[row][col]
    end 

    def valid_neighbor?(row, col)
        in_valid_range?(row) && in_valid_range?(col)
    end 

    def in_valid_range?(num)
        (0..board_size - 1).include?(num) 
    end 

    def get_tiles_without_bombs
        tiles_without_bombs = []
        board.each do |row| 
            row.each { |tile| tiles_without_bombs << tile unless tile.has_bomb } 
        end 
        tiles_without_bombs
    end 

    def get_tiles_with_bombs
        tiles_with_bombs = []
        board.each do |row| 
            row.each { |tile| tiles_with_bombs << tile if tile.has_bomb } 
        end 
        tiles_with_bombs
    end 

    def get_player_entry_position(player_entry)
        player_entry[1..-1].split(',').map { |char| Integer(char) }
    end 

    def reveal_tile(position)
        self[position.first, position.last].revealed = true 
    end 

    def flag_tile(position)
        self[position.first, position.last].flagged = true 
    end 

    def unflag_tile(position)
        self[position.first, position.last].flagged = false 
    end 

    def update_tile(player_entry)
        position = get_player_entry_position(player_entry)
        if player_entry[0] == 'r' 
            reveal_tile(position)
            reveal_neighbor_tiles(position) unless position_has_bomb?(position)
        elsif player_entry[0] == 'f'
            flag_tile(position)
        elsif player_entry[0] == 'u'
            unflag_tile(position)
        end 
    end 

    def get_neighbors_of_position(position)
        self[position.first, position.last].neighbors
    end 

    def any_neighbors_have_bombs?(neighbors)
        neighbors.any? { |neighbor| self[neighbor.first, neighbor.last].has_bomb }
    end 

    def reveal_neighbors_without_bombs(neighbors) 
        neighbors.each { |neighbor| reveal_tile(neighbor) if !position_has_bomb?(neighbor) && !position_flagged?(neighbor) }
    end 

    def reveal_all_neighbors(neighbors) 
        neighbors.each { |neighbor| reveal_tile(neighbor) if !position_flagged?(neighbor) } 
    end 

    def update_neighbors(revealed_tiles)
        neighbors = []
        revealed_tiles.each do |revealed_tile| 
            neighbors_of_revealed_tile = get_neighbors_of_position(revealed_tile)
            neighbors_of_revealed_tile.each { |neighbor_of_revealed_tile| neighbors << neighbor_of_revealed_tile }
        end 
        neighbors.uniq 
    end 

    def reveal_neighbor_tiles(position)
        neighbors = get_neighbors_of_position(position)
        bombs_in_neighbors = false 
        while !bombs_in_neighbors 
            if any_neighbors_have_bombs?(neighbors)
                bombs_in_neighbors = true 
                reveal_neighbors_without_bombs(neighbors)
            else 
                reveal_all_neighbors(neighbors)
                neighbors = update_neighbors(neighbors)
            end 
        end   
    end 

    def reveal_all_bombs
        board.each do |row| 
            row.each { |tile| tile.revealed = true if tile.has_bomb } 
        end 
    end 

    def won? 
        tiles_without_bombs = get_tiles_without_bombs 
        tiles_without_bombs.all? { |tile| tile.revealed }
    end 

    def lost? 
        tiles_with_bombs = get_tiles_with_bombs 
        tiles_with_bombs.any? { |tile| tile.revealed }
    end 

    def over? 
        won? || lost?
    end 

    #method prints board 
    def render 
        minesweeper_board = assign_tile_values_in_minesweeper_board
        drawgrid(minesweeper_board) 
    end 

    #assign tile values. load minesweeper board in 2D array so it can be drawn by drawgrid method. 
    def assign_tile_values_in_minesweeper_board 
        minesweeper_board = []

        board.each do |row| 
            row_arr = []
            row.each do |tile| 
                if tile.revealed
                    if tile.has_bomb 
                        tile.value = 'B'
                    else 
                        if tile.surrounding_bombs == 0 
                            tile.value = ' '
                        else 
                            tile.value = 
                            case tile.surrounding_bombs 
                            when 1 
                                ' 1 '.colorize(:blue)
                            when 2 
                                ' 2 '.colorize(:green)
                            when 3
                                ' 3 '.colorize(:red)
                            when 4
                                ' 4 '.colorize(:cyan)
                            else 
                                " #{tile.surrounding_bombs} ".colorize(:default)
                            end 
                        end 
                    end 
                else 
                    if tile.flagged
                        tile.value = ' F '.colorize(:magenta)
                    else     
                        tile.value = '*'
                    end 
                end 
                row_arr << tile.value 
            end 
            minesweeper_board << row_arr
        end 

        minesweeper_board
    end 

    #method renders an ASCII grid based on a 2D array
    def drawgrid(args, boxlen=3)
        #Define box drawing characters
        side = '│' 
        topbot = '─'
        tl = '  ┌' if board_size <= 10 
        tl = '   ┌' if board_size >= 11 
        tr = '┐'
        bl = '  └' if board_size <= 10 
        bl = '   └' if board_size >= 11 
        br = '┘'
        lc = '  ├' if board_size <= 10 
        lc = '   ├' if board_size >= 11 
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
            #debugger 
            row.each_with_index do |col, index| 
                if index == 0 
                    if board_size <= 10 
                        draw << String(board_row_idx) + " " + side + col.to_s.center(boxlen) 
                    elsif board_size > 10 
                        draw << String(board_row_idx) + "  " + side + col.to_s.center(boxlen) if board_row_idx < 10 
                        draw << String(board_row_idx) + " " + side + col.to_s.center(boxlen) if board_row_idx >= 10 
                    end 
                else 
                    draw << side + col.to_s.center(boxlen)
                end 
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

        print_title_and_x_axis
        puts "\n"
        draw.each { |char| print "#{char}" } 

        true
    end 

    def print_title_and_x_axis 
        puts "MINESWEEPER\n".rjust(27) if board_size == 9 
        puts "MINESWEEPER\n".rjust(29) if board_size == 10 
        puts "MINESWEEPER\n".rjust(40) if board_size == 15 
        puts "MINESWEEPER\n".rjust(50) if board_size == 20 
        if board_size <= 10 
            print " " 
            (0...board_size).each { |i| print "   #{i}" } 
        else 
            print "  "
            (0..9).each { |i| print "   #{i}" } 
            print "  "
            (10..board_size - 1).each do |i| 
                print " #{i} " 
            end 
        end 
    end 

    def set_start_time
        @start_time = Time.now 
    end 

    def session_time 
        (Time.now - start_time).round 
    end 

    def update_time
        @total_time += session_time
    end 

    def calculate_secs 
        if total_time 
            secs = session_time + total_time 
        else 
            secs = session_time
        end 
    end 

    def get_time_to_win_game
        secs = calculate_secs 

        return '0 seconds' if secs == 0 
        minutes = 0 
        hours = 0 

        #count seconds, minutes, & hours  
        if secs < 60 
            seconds = secs 
        else  
            seconds = (secs % 60).round  
            minutes = ((secs / 60) % 60).round 
            hours = (secs / 3600).round 
        end 

        #make seconds string 
        if seconds == 1 
            secs_string = "#{seconds} second"
        else 
            secs_string = "#{seconds} seconds"
        end 

        #make minutes string 
        if minutes == 1 
            mins_string = "#{minutes} minute"
        else 
            mins_string = "#{minutes} minutes"
        end 

        #make hours string 
        if hours == 1 
            hrs_string = "#{hours} hour"
        else 
            hrs_string = "#{hours} hours"
        end 

        #make time string 
        time_string = [] 
        time_string << hrs_string if hours >= 1 
        time_string << mins_string if minutes >= 1 
        time_string << secs_string if seconds >= 1 

        #return time string, seconds to win game 
        [time_string.join(' '), secs] 
    end 

    private
    attr_reader :board

end 


