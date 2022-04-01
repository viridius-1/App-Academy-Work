require "byebug"

class Board
    
    def initialize
        @board = Array.new(8) { Array.new(8) }  
    end

    #fills a new blank chess board
     def fill_array_values
        row_idx = 0 
        @board.map! do |row| 
            col_idx = -1 
            row.map! do |col| 
                col_idx += 1 
                [row_idx, col_idx]
            end
            row_idx += 1 
            row 
        end
    end 

    #loads available positions not under a queen's attack into an array 
    def get_available_positions(queens) 
        available_positions = []
        @board.each do |line| 
            line.each { |space| available_positions << space if !queens.include?(space) && space_under_attack?(space, queens) == false && space != 'Q' }
        end 
        available_positions
    end 

    def get_spaces_under_attack(queens) 
        spaces_under_attack = []

        queens.each do |queen_space| 

            #get spaces above queen space 
            space = queen_space 
            while space.first > 0  
                space = [space.first - 1, space.last]
                spaces_under_attack << space 
            end 

            #get spaces below queen space 
            space = queen_space
            while space.first < @board.length - 1  
                space = [space.first + 1, space.last]
                spaces_under_attack << space 
            end 

            #get spaces to left of queen space 
            space = queen_space 
            while space.last > 0
                space = [space.first, space.last - 1]
                spaces_under_attack << space  
            end 

            #get spaces to right of queen space 
            space = queen_space 
            while space.last < @board.length - 1  
                space = [space.first, space.last + 1]
                spaces_under_attack << space 
            end 

            #get diagonal positions up and to the left of queen space 
            space = queen_space 
            gathering_over = false 
            while !gathering_over
                if space.first == 0 || space.last == 0 
                    gathering_over = true 
                else 
                    space = [space.first - 1, space.last - 1]
                    spaces_under_attack << space 
                end
            end 

            #get diagonal positions down and to the left of queen space 
            space = queen_space 
            gathering_over = false 
            while !gathering_over 
                if space.first == @board.length - 1 || space.last == 0
                     gathering_over = true 
                else 
                    space = [space.first + 1, space.last - 1] 
                    spaces_under_attack << space 
                end 
            end 

            #get diagonal positions up and to the right of queen space 
            space = queen_space 
            gathering_over = false 
            while !gathering_over 
                if space.first == 0 || space.last == @board.length - 1 
                    gathering_over = true 
                else 
                    space = [space.first - 1, space.last + 1]
                    spaces_under_attack << space 
                end 
            end 

            #get diagonal positions down and to the right of queen space 
            space = queen_space 
            gathering_over = false 
            while !gathering_over  
                if space.first == @board.length - 1 || space.last == @board.length - 1 
                     gathering_over = true 
                else 
                    space = [space.first + 1, space.last + 1]
                    spaces_under_attack << space
                end 
            end 

        end 

        spaces_under_attack.uniq   
    end 

    #method returns a boolean of whether a space is under attack by a queen 
    def space_under_attack?(space, queens)
        spaces_under_attack = get_spaces_under_attack(queens)
        spaces_under_attack.include?(space) 
    end 

    #method returns an element of @board
    def [](idx)
        @board[idx] 
    end 

    #prints chess board 
    def print_board
        puts "CHESS BOARD"
        @board.each do |row| 
            row.each do |space| 
                if space == 'Q' 
                    print "Q "
                else 
                    print "_ "
                end 
            end 
            puts "\n"
        end 
    end 

end 