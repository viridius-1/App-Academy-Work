class Board 

    attr_reader :size

    def self.print_grid(grid)
        grid.each do |row| 
            print "#{row.join(' ')}\n"
        end 
    end 

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n 
    end 

    def [](position)
        row = position[0]
        column = position[1]
        @grid[row][column]
    end 

    def []=(position, value)
        row = position[0]
        column = position[1]
        @grid[row][column] = value
    end 
 
    def num_ships
        ships = 0 
        @grid.each do |row| 
            row.each do |spot| 
                ships += 1 if spot == :S 
            end 
        end 
        ships 
    end 

    def attack(position)
        if self[position] == :S 
            self[position] = :H 
            puts "you sunk my battleship!"
            true 
        else  
            self[position] = :X 
            false 
        end 
    end 

    def place_random_ships
        ships = (@size * 0.25).round
        ship_positions = []

        until ship_positions.length == ships 
            row = rand(0...@grid.length)
            column = rand(0...@grid.length)

            if !(ship_positions.include?([row, column]))
                @grid[row][column] = :S 
                ship_positions << [row, column]
            end 
        end 
    end 

    def hidden_ships_grid
        hidden_grid = Array.new(@grid.length) { Array.new(@grid.length, nil) }

        @grid.each_with_index do |row, row_idx| 
            row.each_with_index do |spot, col_idx| 
                if spot == :S
                    hidden_grid[row_idx][col_idx] = :N  
                else 
                    hidden_grid[row_idx][col_idx] = spot 
                end 
            end 
        end 

        hidden_grid
    end 

    def cheat 
        Board.print_grid(@grid)
    end 

    def print 
        hidden_grid = self.hidden_ships_grid 
        Board.print_grid(hidden_grid)
    end 

end 