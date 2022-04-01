require_relative "board.rb" 
require "byebug"

class Solver 

    attr_reader :current_tile, :current_tile_value, :game, :movable_tiles, :seen_tiles, :tile_idx

    def initialize(file)
        @game = Board.from_file("#{file}")
        @movable_tiles = []
        @seen_tiles = Hash.new(0)
        @current_tile = nil 
        @current_tile_value = nil 
        @alltime_used_values = Hash.new { |hash, key| hash[key] = [] }
        @tile_idx = 0 
    end 

    def reset
        @seen_tiles = Hash.new(0)
        @alltime_used_values = Hash.new { |hash, key| hash[key] = [] }
    end 

    def solve 
        start_time = Time.now 
        cycles = 0 
        get_movable_tiles 
        until @game.solved?
            @current_tile = @movable_tiles[@tile_idx]
            if @current_tile == [0, 0]
                reset 
                cycles += 1 
            end 
            @current_tile_value = @game[[@current_tile[0], @current_tile[1]]].value if @seen_tiles[@current_tile] > 0 
            get_available_values_per_tile 
            if valid_move?
                move_tile
                @tile_idx += 1 
            else    
                @game[[@current_tile[0], @current_tile[1]]].value = "0" 
                @tile_idx -=1 if @tile_idx != 0 
            end 
            @seen_tiles[@current_tile] += 1 
            @alltime_used_values[@current_tile] << @game[[@current_tile[0], @current_tile[1]]].value if @game[[@current_tile[0], @current_tile[1]]].value != "0"
            print "\r#{@game.render}" 
            print "\r#{cycles} cycles.\n"
        end 
        finish(start_time, cycles)
    end 

    def finish(start_time, cycles)
        puts "\n"
        @game.render 
        puts "SUDOKU PUZZLE SOLVED!"
        puts "Solved in #{get_time(Time.now - start_time)}."
        puts "#{cycles} cycles"
    end 

    def get_movable_tiles
        @game.grid.each_with_index do |row, row_idx| 
            row.each_with_index { |tile, col_idx| @movable_tiles << [row_idx, col_idx] if tile.given == false } 
        end 
    end 

    def valid_move? 
        !@game[[@current_tile[0], @current_tile[1]]].available_values.empty? 
    end 

    def move_tile 
        @game[[@current_tile[0], @current_tile[1]]] = @game[[@current_tile[0], @current_tile[1]]].available_values.sample 
    end 

    def get_available_values_per_tile
        @game.grid.each_with_index do |row, row_idx| 
            row.each_with_index do |tile, col_idx| 
                tile.get_available_values([row_idx, col_idx], @game, @current_tile_value, @current_tile, @alltime_used_values) 
            end 
        end 
    end 

    #method takes in a quantity of seconds. returns a string of time. 
    def get_time(secs)
        minutes = 0 

        if secs < 60 
            seconds = secs 
        else 
            minutes = (secs / 60).round 
            seconds = (secs % 60).round  
        end 

        if minutes == 1 
            mins_string = "#{minutes} minute"
        else 
            mins_string = "#{minutes} minutes"
        end 

        if seconds == 1 
            secs_string = "#{seconds} second"
        else 
            secs_string = "#{seconds} seconds"
        end 

        if minutes < 1 
            secs_string 
        else 
            mins_string + " " + secs_string
        end 
    end 

end 