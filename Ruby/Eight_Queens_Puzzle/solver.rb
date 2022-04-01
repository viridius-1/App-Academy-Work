require_relative "board.rb"
require "byebug"

class Solver 

    attr_reader :queens, :chooser, :all_positions, :available_positions

    attr_accessor :board 

    def initialize 
        @board = Board.new 
        @queens = []
        @available_positions = []
        @chooser = { 
            [0, 0] => [1, 0], 
            [1, 0] => [2, 0], 
            [2, 0] => [3, 0], 
            [3, 0] => [4, 0], 
            [4, 0] => [5, 0], 
            [5, 0] => [6, 0], 
            [6, 0] => [7, 0], 
            [0, 1] => [1, 1], 
            [1, 1] => [2, 1], 
            [2, 1] => [3, 1], 
            [3, 1] => [4, 1], 
            [4, 1] => [5, 1], 
            [5, 1] => [6, 1], 
            [6, 1] => [7, 1], 
            [0, 2] => [1, 2], 
            [1, 2] => [2, 2], 
            [2, 2] => [3, 2], 
            [3, 2] => [4, 2], 
            [4, 2] => [5, 2],
            [5, 2] => [6, 2],
            [6, 2] => [7, 2], 
            [0, 3] => [1, 3], 
            [1, 3] => [2, 3], 
            [2, 3] => [3, 3], 
            [3, 3] => [4, 3], 
            [4, 3] => [5, 3], 
            [5, 3] => [6, 3], 
            [6, 3] => [7, 3], 
            [0, 4] => [1, 4], 
            [1, 4] => [2, 4], 
            [2, 4] => [3, 4], 
            [3, 4] => [4, 4], 
            [4, 4] => [5, 4], 
            [5, 4] => [6, 4], 
            [6, 4] => [7, 4], 
            [0, 5] => [1, 5], 
            [1, 5] => [2, 5], 
            [2, 5] => [3, 5], 
            [3, 5] => [4, 5], 
            [4, 5] => [5, 5], 
            [5, 5] => [6, 5], 
            [6, 5] => [7, 5], 
            [0, 6] => [1, 6], 
            [1, 6] => [2, 6], 
            [2, 6] => [3, 6], 
            [3, 6] => [4, 6], 
            [4, 6] => [5, 6], 
            [5, 6] => [6, 6], 
            [6, 6] => [7, 6], 
            [0, 7] => [1, 7], 
            [1, 7] => [2, 7], 
            [2, 7] => [3, 7], 
            [3, 7] => [4, 7], 
            [4, 7] => [5, 7], 
            [5, 7] => [6, 7], 
            [6, 7] => [7, 7], 
        }
        @all_positions = get_all_positions 
    end 

    #method returns all positions 
    def get_all_positions 
        all_positions = []
        @chooser.each do |k, v| 
            all_positions << k 
            all_positions << v 
        end 
        all_positions.uniq
    end 

    #method loads a blank chess board
    def load_positions 
        @board.fill_array_values
    end 

    #method clears the board and loads a new board. resets @queens. 
    def reset
        load_positions 
        @queens = []
    end 

    #method returns available positions on the board 
    def load_available_positions 
        @available_positions = @board.get_available_positions(@queens)
    end 

    #method returns a boolean of whether there are 8 queens 
    def eight_queens?
        @queens.length == 8 
    end 

    #method places a queen on the board and loads queen into @queens array
    def place_queen(queen)
        @queens << queen 
        @board[queen.first][queen.last] = 'Q'
    end 

    #method generates a random array of queens where each successive queen is not under attack from any other  
    def generate_random_queens
        attempt_over = false 
        while !attempt_over 
            load_available_positions 
            if eight_queens? || @available_positions.empty?
                attempt_over = true 
            else 
                if @queens.empty? 
                    queen = @all_positions.sample 
                    place_queen(queen)
                else 
                    queen = @available_positions.sample 
                    if !@queens.include?(queen)
                        place_queen(queen) 
                    end
                end 
            end
        end
    end 

    #method solves the puzzle by getting random combinations of queens 
    def solve 
        starting_time = Time.now 
        tries = 0  

        until solved? 
            reset 
            tries += 1 
            generate_random_queens 
            print "\r#{tries} tries"
        end 

        ending_time = Time.now 
        elapsed_mins = ((starting_time - ending_time) / 60).round
        puts "\n\nPuzzle Solved!"
        puts "Finished in #{elapsed_mins} minutes.\n\n"
        print_chess_board
    end 

    #method returns a boolean of whether the puzzle is solved 
    def solved? 
        return false if @queens.empty?
        if eight_queens? 
            @queens.each { |queen| return false if @board.space_under_attack?(queen, @queens) } 
            true 
        else    
            false 
        end  
    end 

    #method prints the board 
    def print_chess_board
        @board.print_board 
    end

end 