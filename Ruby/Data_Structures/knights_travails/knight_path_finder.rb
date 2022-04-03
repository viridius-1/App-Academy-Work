require_relative "board.rb"
require_relative "tree_node.rb"

class KnightPathFinder 

    attr_accessor :board, :knight_possible_moves

    #method returns all possible moves of a knight at a position 
    def self.knight_valid_moves(position)
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
        @board = Board.new(8)
        @root_node = PolyTreeNode.new(position)
        @move_tree = build_move_tree 
    end 

    def build_move_tree 
    end 

end 