require_relative "board.rb"
require_relative "human_player.rb"

class Game 

    def initialize(n, *player_marks) 
        @players = player_marks.map { |player| HumanPlayer.new(player) }  
        @current_player = @players.first 
        @board = Board.new(n) 
    end 

    def switch_turn 
        @current_player = @players.rotate!(1).first
    end 

    def play 
        while @board.empty_positions? 
            @board.print_board
            @board.place_mark(@current_player.get_position(@board.grid.length), @current_player.mark)
            if @board.win?(@current_player.mark)
                return "Player #{@current_player.mark} Wins!"
            else 
                self.switch_turn 
            end 
        end 
        return "The game has ended in a tie."
    end

end 