require_relative 'player'
require_relative 'chess_node'

class SuperChessComputer < ComputerPlayer  

    attr_reader :name, :node 

    def initialize(name, color, board)
        super
        @node = ChessNode.new(board, color)
    end 

end 

