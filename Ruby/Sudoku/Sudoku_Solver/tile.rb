class Tile 

    attr_reader :given
    attr_accessor :available_values, :used_values, :value 

    def initialize(value, given_boolean)
        @value = value 
        @given = given_boolean
        @available_values = []
        @used_values = []
    end 

    def get_available_values(position, game, current_tile_value=nil, current_tile, alltime_used_values) 
        @available_values = [] 
        @used_values = []
        if @given == false  
            @used_values = (@used_values + row_used_values(position, game) + column_used_values(position, game) + subgrid_used_values(position, game)).uniq 
            @used_values << current_tile_value if current_tile_value 
            game.correct_values.each { |value| @available_values << value if !@used_values.include?(value) && !alltime_used_values[current_tile].include?(value) }    
            @available_values.uniq!
        end  
    end 

    def row_used_values(position, game)
        used_values = []

        row_idx = position.first 
        col_idx = 0 
        while col_idx < game.grid.length 
            if col_idx == position.last 
                col_idx += 1 
                next 
            end 
            used_values << game[[row_idx, col_idx]].value if game[[row_idx, col_idx]].value != "0"  
            col_idx += 1 
        end 

        used_values.uniq 
    end 

    def column_used_values(position, game)
        used_values = []

        col_idx = position.last 
        row_idx = 0 
        while row_idx < game.grid.length 
            if row_idx == position.first 
                row_idx += 1 
                next 
            end 
            used_values << game[[row_idx, col_idx]].value if game[[row_idx, col_idx]].value != "0" 
            row_idx += 1 
        end 

        used_values.uniq 
    end 

    def subgrid_used_values(position, game)
        used_values = []
        subgrid = which_subgrid(position) 

        row_idx = subgrid[0][0]

        while row_idx <= subgrid[1][0]
            col_idx = subgrid[0][1]
            while col_idx <= subgrid[1][1]
                if [row_idx, col_idx] == position 
                    col_idx += 1 
                    next 
                end 
                used_values << game[[row_idx, col_idx]].value if game[[row_idx, col_idx]].value != "0"
                col_idx += 1 
            end 
            row_idx += 1 
        end 

        used_values.uniq 
    end 

    #method returns the subgrid a position is in 
    def which_subgrid(position)
        subgrids = [ 
            [[0, 0], [2, 2]], 
            [[0, 3], [2, 5]], 
            [[0, 6], [2, 8]], 
            [[3, 0], [5, 2]], 
            [[3, 3], [5, 5]], 
            [[3, 6], [5, 8]], 
            [[6, 0], [8, 2]], 
            [[6, 3], [8, 5]], 
            [[6, 6], [8, 8]] 
        ]
        subgrids.each { |subgrid| return subgrid if (position.first >= subgrid[0][0] && position.first <= subgrid[1][0]) && (position.last >= subgrid[0][1] && position.last <= subgrid[1][1]) } 
    end 

end 