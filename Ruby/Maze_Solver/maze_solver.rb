require "byebug"

class MazeSolver 

    attr_reader :maze, :current_square, :walkable, :not_walkable, :open_list, :closed_list, :path, :sorted_open_list_by_fscore, :end_greater_than_start

    def initialize(maze)
        @maze = maze.split("\n").map { |line| line.split('') }
        @end_greater_than_start = nil 
        @current_square = find_start
        @start_position = find_start 
        @end_position = find_end 
        @furthest_wall = find_furthest_wall 
        @walkable, @not_walkable = eval_walkable
        @open_list = {} 
        @sorted_list = nil 
        @closed_list = {@start_position => [4, 0, 4, @start_position]}
        @path = [@current_square]
    end 

    #returns boolean of whether maze is valid 
    def valid_maze?
        @maze.any? { |line| line.include?('S') } && maze.any? { |line| line.include?('E') }
    end 

    #method returns start of maze 
    def find_start
        @maze.each_with_index do |line, row| 
            line.each_with_index { |pos, col| return [row, col] if pos == 'S' } 
        end 
    end 

    #method returns end of maze 
    def find_end 
        @maze.each_with_index do |line, row| 
            line.each_with_index { |pos, col| return [row, col] if pos == 'E' } 
        end 
    end 

    #method returns furthest wall 
    def find_furthest_wall
        furthest_wall = nil 
        clear = false

        if @end_position.last >= @start_position.last 
            @end_greater_than_start = true 
            @end_position.last.downto(1).each do |col| 
                clear = true 
                1.upto(@maze.length - 2).each do |row|  
                    if @maze[row][col] == "*"
                        furthest_wall = [row, col] 
                        clear = false 
                    end 
                end 
                return furthest_wall if clear == true 
            end 
        else
            @end_greater_than_start = false  
            @end_position.last.upto(@maze[0].length - 2).each do |col|
                clear = true 
                (@maze.length - 2).downto(1).each do |row| 
                    if @maze[row][col] == "*"
                        furthest_wall = [row, col] 
                        clear = false 
                    end 
                end 
                return furthest_wall if clear == true 
            end 
        end 
    end 

    #method returns walkable and non-walkable squares in the maze 
    def eval_walkable 
        walkable_squares = []
        not_walkable_squares = []

        @maze.each_with_index do |line, row| 
            line.each_with_index do |pos, col| 
                if pos != "*" 
                    walkable_squares << [row, col]
                else 
                    not_walkable_squares << [row, col] 
                end 
            end 
        end 
       
        [walkable_squares, not_walkable_squares]
    end 

    #method returns walkable surrounding squares 
    def get_surrounding_squares 
        surrounding_squares = []
        
        surrounding_squares << [@current_square.first - 1, @current_square.last - 1] if @walkable.include?([@current_square.first - 1, @current_square.last - 1]) && !@path.include?([@current_square.first - 1, @current_square.last - 1])
        surrounding_squares << [@current_square.first - 1, @current_square.last] if @walkable.include?([@current_square.first - 1, @current_square.last]) && !@path.include?([@current_square.first - 1, @current_square.last])
        surrounding_squares << [@current_square.first - 1, @current_square.last + 1] if @walkable.include?([@current_square.first - 1, @current_square.last + 1]) && !@path.include?([@current_square.first - 1, @current_square.last + 1])
        surrounding_squares << [@current_square.first, @current_square.last - 1] if @walkable.include?([@current_square.first, @current_square.last - 1]) && !@path.include?([@current_square.first, @current_square.last - 1])
        surrounding_squares << [@current_square.first, @current_square.last + 1] if @walkable.include?([@current_square.first, @current_square.last + 1]) && !@path.include?([@current_square.first, @current_square.last + 1])
        surrounding_squares << [@current_square.first + 1, @current_square.last - 1] if @walkable.include?([@current_square.first + 1, @current_square.last - 1]) && !@path.include?([@current_square.first + 1, @current_square.last - 1]) 
        surrounding_squares << [@current_square.first + 1, @current_square.last] if @walkable.include?([@current_square.first + 1, @current_square.last]) && !@path.include?([@current_square.first + 1, @current_square.last])
        surrounding_squares << [@current_square.first + 1, @current_square.last + 1] if @walkable.include?([@current_square.first + 1, @current_square.last + 1]) && !@path.include?([@current_square.first + 1, @current_square.last + 1])
    
        surrounding_squares 
    end 

    #method calculates g value.  
    def calc_g(square, current_square)
        if ((square.first - current_square.first).abs + (square.last - current_square.last).abs) == 2 
            14 + @closed_list[current_square][1]
        else 
            10 + @closed_list[current_square][1]
        end 
    end 

    #method calculates h value 
    def calc_h(square)
        ((square.first - @end_position.first).abs + (square.last - @end_position.last).abs) * 10 
    end 

    #method calculates f value 
    def calc_f(square)
        calc_g(square) + calc_h(square)
    end 

    #method adds appropriate squares to open list with parent and f, g, & h scores. square is key. value is in the form [f, g, h, parent].  
    def add_to_open_list(squares, current_square)
        squares.each do |square| 
            if !@open_list.has_key?(square) 
                g = calc_g(square, current_square)
                h = calc_h(square)
                f = g + h 
                @open_list[square] = [f, g, h, current_square] 
            else 
                g = calc_g(square, current_square)
                f = g + @open_list[square][2] 
                @open_list[square][0] = f 
                @open_list[square][1] = g 
                if g < @open_list[square][1]
                    @open_list[square][3] = current_square 
                end 
            end 
        end 
    end 

    #method takes the sorted list by f score and then sorts it by h score 
    def sort_list
        arr = @open_list.sort_by { |square, data| data[0] }

        #takes sorted list by f score and sorts it by h score
        sorted = false 
        while !sorted 
            sorted = true 
            idx = 0 
            while idx < arr.length - 1 
            if arr[idx][1][0] == arr[idx + 1][1][0] 
                if arr[idx][1][2] > arr[idx + 1][1][2]
                arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
                sorted = false 
                end 
            end  
            idx += 1 
            end 
        end 
 
        #takes sorted list by f score then h score. then sorts it by distance from end point if f, g, and h are equal 
        sorted = false 
        while !sorted 
            sorted = true 
            idx = 0 
            while idx < arr.length - 1 
            if arr[idx][1][0] == arr[idx + 1][1][0] && arr[idx][1][1] == arr[idx + 1][1][1] && arr[idx][1][2] == arr[idx + 1][1][2]
                if ((@end_position.first - arr[idx][0].first) + (@end_position.last - arr[idx][0].last)).abs > ((@end_position.first - arr[idx + 1][0].first) + (@end_position.last - arr[idx + 1][0].last)).abs  
                    arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
                    sorted = false 
                end 
            end 
            idx += 1 
            end 
        end 

        @sorted_list = arr   
    end 

    #moves to new square. takes new square out of open list and puts it in closed list. 
    def move_to_new_square(surrounding_squares)
        new_square = nil 
        new_square_data = nil 
        #debugger 
        @sorted_list.each do |square| 
            if @furthest_wall && @end_greater_than_start 
                if surrounding_squares.include?(square[0]) && !(square[0].first >= @furthest_wall.first && square[0].last >= @furthest_wall.last) && !(square[0].first < @current_square.first && square[0].last < @current_square.last)   
                    new_square = square[0]
                    new_square_data = square[1]
                    break 
                end  
            elsif @furthest_wall && @end_greater_than_start == false  
                if surrounding_squares.include?(square[0]) && !(square[0].first <= @furthest_wall.first && square[0].last <= @furthest_wall.last) && !(square[0].first > @current_square.first && square[0].last > @current_square.last)
                    new_square = square[0]
                    new_square_data = square[1]
                    break 
                end 
            elsif @furthest_wall == nil && @end_greater_than_start
                if surrounding_squares.include?(square[0]) && !(square[0].first < @current_square.first && square[0].last < @current_square.last)
                    new_square = square[0]
                    new_square_data = square[1]
                    break 
                end 
            elsif @furthest_wall == nil && @end_greater_than_start == false 
                if surrounding_squares.include?(square[0]) && !(square[0].first > @current_square.first && square[0].last > @current_square.last)
                    new_square = square[0]
                    new_square_data = square[1]
                    break 
                end 
            end 
        end 
        
        @open_list.delete(new_square)
        @closed_list[new_square] = new_square_data
        @current_square = new_square
        @path << new_square
        @maze[new_square.first][new_square.last] = 'X'
    end 

    #method makes a move on the maze 
    def move 
        surrounding_squares = get_surrounding_squares 
        add_to_open_list(surrounding_squares, @current_square)
        sort_list 
        move_to_new_square(surrounding_squares)
    end 

    
    #method solves maze 
    def solve 
        if valid_maze? 
            until solved?
                move   
            end 
            @path << @end_position
            print_solution
        end
    end 

    #method returns boolean of whether the maze is solved 
    def solved?
        surrounding_squares = get_surrounding_squares 
        surrounding_squares.each { |square| return true if @maze[square.first][square.last] == "E" } 
        false 
    end 

    #method prints maze solution
    def print_solution 
        puts "\n"
        @maze.each do |line| 
            line.each { |data| print "#{data} " } 
            puts "\n"
        end 
        print "\nPath = "
        @path.each do |square| 
            print "#{square} "
        end 
        puts "\nMaze Solved!"
    end 

end 



