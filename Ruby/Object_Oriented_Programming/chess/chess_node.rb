require_relative 'game'
require 'byebug'

class ChessNode

    attr_accessor :board, :next_mover_color, :prev_move_pos

    def initialize(board, next_mover_color, prev_move_pos = nil)
        @board = board 
        @next_mover_color = next_mover_color
        @prev_move_pos = prev_move_pos
    end

    def children 
        children = []

        board.rows.each do |row| 
            row.each do |piece| 
                if piece.class != NullPiece
                    piece.valid_moves.each do |move| 
                        duped_board, next_mover_color, prev_move_pos = generate_child(piece, move)
                        children << ChessNode.new(duped_board, next_mover_color, prev_move_pos)
                    end 
                end 
            end 
        end 

        children 
    end 

    def generate_child(piece, move)
        duped_board = board.duplicate 
        duped_board.move_piece!(piece.position, move) 
        prev_move_pos = move 
        [duped_board, piece.opponent_color, prev_move_pos]
    end 

    def losing_node?(color) 
        if board.checkmate?(color)
            return player_lost?(color)
        end 

        if next_mover_color == color 
            all_player_children_nodes_losers?(color)
        else 
            any_player_children_nodes_losers_with_opponent_move?(color)
        end 
    end 

    def winning_node?(color)
        if board.checkmate?(color)
            return player_won?(color)
        end 

        if next_mover_color == color 
            any_player_children_node_winner?(color)
        else 
            all_opponent_children_nodes_winners_for_player?(color)
        end 
    end 

    def player_lost?(color)
        if color == :white 
            return true if next_mover_color == :black 
        elsif color == :black 
            return true if next_mover_color == :white 
        end  
        false 
    end 

    def player_won?(color)
        next_mover_color == color 
    end 

    def all_player_children_nodes_losers?(color)
        children.all? { |child_node| child_node.losing_node?(color) }
    end 

    def any_player_children_nodes_losers_with_opponent_move?(color)
        children.any? { |child_node| child_node.losing_node?(color) }
    end 

    def any_player_children_node_winner?(color)
        children.any? { |child_node| child_node.winning_node?(color) }
    end 

    def all_opponent_children_nodes_winners_for_player?(color)
        children.all? { |child_node| child_node.winning_node?(color) }
    end 

end 