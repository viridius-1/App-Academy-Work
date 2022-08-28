class Tile 

    attr_reader :position
    attr_accessor :flagged, :has_bomb, :neighbors, :revealed, :surrounding_bombs, :value 

    def initialize(row, col)
        @has_bomb = false 
        @surrounding_bombs = 0 
        @flagged = false 
        @revealed = false 
        @value = nil 
        @position = [row, col]
        @neighbors = []
    end 

end 