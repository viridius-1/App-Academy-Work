require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos  

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board 
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def alternate_mark(mark)
    if mark == :x 
      :o 
    else 
      :x 
    end 
  end 

  def oppponent_won?(opponent_mark)
    board.over? && board.winner == opponent_mark 
  end 

  def player_won_or_tied?(evaluator)
    board.over? && (board.winner == evaluator || board.winner == nil)
  end 

  def any_player_children_node_loser?(evaluator)
    children.any? { |child_node| child_node.losing_node?(evaluator) }
  end 

  def losing_node?(evaluator)
    opponent_mark = alternate_mark(evaluator) 

    if oppponent_won?(opponent_mark)
      return true 
    elsif player_won_or_tied?(evaluator)
      return false 
    end 

    any_player_children_node_loser?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    board.rows.each_with_index do |row, row_idx| 
      row.each_with_index do |col, col_idx| 
        if board.empty?([row_idx, col_idx])
          duped_board, next_mover_mark, prev_move_pos = generate_child(row_idx, col_idx) 
          children << TicTacToeNode.new(duped_board, next_mover_mark, prev_move_pos)
        end 
      end 
    end 

    children
  end 

  #method generates attribute of a child board - the current board state with the next move, the mark that will be used in the move after this child, and its previous move position
  def generate_child(row, col)
    duped_board = board.dup 
    duped_board.rows[row][col] = next_mover_mark
    prev_move_pos = [row, col] 
    [duped_board, alternate_mark(next_mover_mark), prev_move_pos]
  end 

end
