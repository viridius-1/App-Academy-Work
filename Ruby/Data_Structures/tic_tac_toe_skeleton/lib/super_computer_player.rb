require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer

  attr_reader :node 

  def move(game, mark)
    debugger 
    @node = TicTacToeNode.new(game.board, mark)
    node.children.each { |child_node| return child_node.prev_move_pos if child_node.winning_node?(mark) }
    node.children.each { |child_node| return child_node.prev_move_pos unless child_node.losing_node?(mark) } 
    raise "Something is wrong, I'm not supposed to lose."
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jake")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
