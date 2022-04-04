require_relative "tree_node.rb"

class KnightPathFinder 

    attr_accessor :considered_positions, :root_node 

    #method returns all possible moves of a knight at a position 
    def self.valid_moves(position)
        knight_row = position[0]
        knight_col = position[1]
        @@knight_possible_moves = []

        #get move up and to the left 
        row_moved_to = knight_row - 2 
        col_moved_to = knight_col - 1 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move up and to the right 
        row_moved_to = knight_row - 2 
        col_moved_to = knight_col + 1 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move to the right and up 
        row_moved_to = knight_row - 1
        col_moved_to = knight_col + 2 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move to the right and down
        row_moved_to = knight_row + 1 
        col_moved_to = knight_col + 2 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move down and to the right 
        row_moved_to = knight_row + 2 
        col_moved_to = knight_col + 1 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move down and to the left 
        row_moved_to = knight_row + 2 
        col_moved_to = knight_col - 1 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move to the left and down 
        row_moved_to = knight_row + 1 
        col_moved_to = knight_col - 2 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        #get move to the left and up 
        row_moved_to = knight_row - 1
        col_moved_to = knight_col - 2 
        add_knight_move_if_on_board(row_moved_to, col_moved_to)

        @@knight_possible_moves        
    end 

    def self.add_knight_move_if_on_board(row, col)
        @@knight_possible_moves << [row, col] if self.valid_position?(row, col)
    end 

    #method returns a boolean of whether a position is on chess board 
    def self.valid_position?(row, col)
        [row, col].all? { |i| (0..7).include?(i) }
    end 

    def initialize(position)
        @root_node = PolyTreeNode.new(position)
        @considered_positions = [root_node.position]
        build_move_tree 
    end 

    def new_move_positions(position)
        moves = KnightPathFinder.valid_moves(position)
        new_moves = moves.select { |move| !considered_positions.include?(move) }
        new_moves.each { |move| @considered_positions << move }
    end 

    def build_move_tree 
        queue = [root_node] 
        until queue.empty? 
            first_node_in_queue = queue[0]
            child_positions_of_node = new_move_positions(first_node_in_queue.position)
            child_positions_of_node.each do |child_position_of_node| 
                child = PolyTreeNode.new(child_position_of_node) 
                queue << child
                first_node_in_queue.children << child
                child.parent = first_node_in_queue
            end 
            queue.shift 
        end 
    end 

    def find_path(end_position) 
        end_node = root_node.bfs(end_position)
        trace_path_back(end_node)
    end 

    def trace_path_back(end_node)
        path = [end_node]
        last_node_in_path = path[-1]  

        until last_node_in_path == root_node 
            path << last_node_in_path.parent 
            last_node_in_path = path[-1]
        end 

        path.reverse.map { |node| node.position } 
    end 

end 