require_relative "board.rb" 
require_relative "player.rb" 

class Game 

    attr_reader :game, :player  

    def initialize(file, player)
        @game = Board.from_file("#{file}")
        @player = Player.new(player) 
    end 

    def play 
        until @game.solved? 
            puts "\n"
            @game.render 
            prompt_for_position
            @player.prompt_for_value
            @game[[@player.user_position.first, @player.user_position.last]] = @player.user_value 
        end 
        puts "\n"
        puts "CONGRATULATIONS! YOU WON SUDOKU!".rjust(36)
        @game.render 
    end 

    def prompt_for_position
        valid = false 
        while !valid 
            player_position_choice = @player.prompt_for_position
            if @game[[player_position_choice.first, player_position_choice.last]].given 
                @game[[player_position_choice.first, player_position_choice.last]].no_change_msg 
            else 
                valid = true 
            end 
        end 
    end 

end 