require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game 

    attr_reader :current_player, :board 

    def initialize(n, hash) 
        @players = []
        hash.each do |mark, bool| 
            if bool 
                @players << ComputerPlayer.new(mark)
            else 
                @players << HumanPlayer.new(mark) 
            end 
        end 
        @current_player = @players.first 
        @board = Board.new(n) 
    end 

    def switch_turn 
        @current_player = @players.rotate!(1).first
    end 

    def play 
        while @board.empty_positions? 
            @board.print_board

            if @current_player.class == HumanPlayer 
                @board.place_mark(@current_player.get_position(@board.legal_positions, @board.grid.length, @board), @current_player.mark)
            else 
                @board.place_mark(@current_player.get_position(@board.legal_positions), @current_player.mark)
            end 

            if @board.win?(@current_player.mark)
                puts 
                @board.print_board
                return "#{@current_player.class} #{@current_player.mark} Wins!"
            else 
                self.switch_turn 
            end 
        end 

        return "The game has ended in a tie."
    end

end 