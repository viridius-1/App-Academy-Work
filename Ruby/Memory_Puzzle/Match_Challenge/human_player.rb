require_relative "card.rb"
require_relative "board.rb"
require_relative "game.rb"
require "byebug"

class HumanPlayer 

    attr_reader :board_size, :name

    def initialize(name, board_size)
        @name = name 
        @board_size = board_size
    end 

    def get_guess(game, player_name, turns, turns_allowed, bomb_hits)
        valid_guess = false 
        while !valid_guess
            puts "#{@name}, enter a guess. Numbers must be between 0 and #{@board_size - 1}. Format it like this example. (Example: 1,2)"
            user_guess = gets.chomp     
            user_guess_arr = user_guess.split(',').map! { |str| str.gsub(" ", "") }  
            if user_guess_arr.all? { |el| el.length == 1 && el.ord >= 48 && el.ord <= (@board_size - 1).to_s.ord } && game[user_guess_arr.first.to_i, user_guess_arr.last.to_i].face_up == false && user_guess.length >= 3
                valid_guess = true 
                user_guess_arr.map! { |el| el.to_i }
            else
                system("clear")
                game.render(turns, turns_allowed, bomb_hits)
                puts "Invalid Guess!"
            end      
        end 
        user_guess_arr
    end 

end 