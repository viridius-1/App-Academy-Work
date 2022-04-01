require_relative "board.rb"
require "byebug"

class Solver 

    attr_reader :queens, :chooser, :all_positions, :available_positions, :attempt_record 

    attr_accessor :board 

    def initialize 
        @board = Board.new 
        @queens = []
        @available_positions = []
        @attempt_record = []
        @all_positions = [] 
    end 

    #method returns all positions 
    def load_all_positions 
        load_positions.each do |line|
            line.each { |position| @all_positions << position }  
        end 
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
                    potential_queens = @queens + [queen]
                    if !@queens.include?(queen) && !@attempt_record.include?(potential_queens) 
                        place_queen(queen) 
                    end
                end 
            end
        end
        @attempt_record << @queens 
    end 

    #method solves the puzzle by getting random combinations of queens 
    def solve 
        starting_time = Time.now 
        tries = 0  
        load_all_positions

        until solved? 
            reset 
            tries += 1 
            generate_random_queens 
            print "\r#{tries} tries"
        end 

        ending_time = Time.now 
        elapsed_secs = (ending_time - starting_time).round
        puts "\n\nPuzzle Solved!"
        if elapsed_secs == 1 
            puts "Finished in #{elapsed_secs} second.\n\n"
        else 
            puts "Finished in #{elapsed_secs} seconds.\n\n"
        end 
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