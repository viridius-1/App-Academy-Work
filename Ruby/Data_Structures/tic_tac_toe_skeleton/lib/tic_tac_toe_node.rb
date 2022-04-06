require_relative 'tic_tac_toe'

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

  def player_won?(evaluator) 
    board.winner == evaluator
  end 

  def player_lost?(evaluator)
    board.winner != evaluator && board.winner != nil 
  end 

  def all_player_children_nodes_losers?(evaluator)
    children.all? { |child_node| child_node.losing_node?(evaluator) }
  end 

  def any_player_children_nodes_losers_with_opponent_move?(evaluator) 
    children.any? { |child_node| child_node.losing_node?(evaluator) }
  end 

  def any_player_children_node_winner?(evaluator)
    children.any? { |child_node| child_node.winning_node?(evaluator) }
  end 

  def all_opponent_children_nodes_winners_for_player?(evaluator)
    children.all? { |child_node| child_node.winning_node?(evaluator) }
  end 

  def losing_node?(evaluator)
    if board.over? 
      return player_lost?(evaluator)
    end 

    if next_mover_mark == evaluator 
      all_player_children_nodes_losers?(evaluator)
    else 
      any_player_children_nodes_losers_with_opponent_move?(evaluator)
    end 
  end

  def winning_node?(evaluator)
    if board.over? 
      return player_won?(evaluator) 
    end 

    if next_mover_mark == evaluator
      any_player_children_node_winner?(evaluator)
    else 
      all_opponent_children_nodes_winners_for_player?(evaluator)
    end 
  end
  
  #method generates an array of all moves that can be made after the current move.
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

  #method generates attributes of a child board - the current board state with the next move, the mark that will be used in the move after this child, and its previous move position
  def generate_child(row, col)
    duped_board = board.dup 
    duped_board.rows[row][col] = next_mover_mark
    prev_move_pos = [row, col] 
    [duped_board, alternate_mark(next_mover_mark), prev_move_pos]
  end 

end
