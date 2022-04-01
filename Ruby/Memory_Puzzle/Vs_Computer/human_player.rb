require_relative "card.rb"
require_relative "board.rb"
require_relative "game.rb"
require_relative "computer_player.rb"

class HumanPlayer 

    attr_reader :name

    def initialize(name)
        @name = name 
    end 

    def get_guess(game, player_name, computer_player_name, player_pts, computer_pts)
        valid_guess = false 
        while !valid_guess
            puts "#{@name}, enter a guess. Numbers must be between 0 and 3. Format it like this example. (Example: 1,2)"
            user_guess = gets.chomp     
            user_guess_arr = user_guess.split(',').map! { |str| str.gsub(" ", "") }  
            if user_guess_arr.all? { |el| el.length == 1 && el.ord >= 48 && el.ord <= 51 } && game[user_guess_arr.first.to_i, user_guess_arr.last.to_i].face_up == false && user_guess.length >= 3
                valid_guess = true 
                user_guess_arr.map! { |el| el.to_i }
            else
                puts "\n"
                game.render(player_name, computer_player_name, player_pts, computer_pts)
                puts "Invalid Guess!"
            end 
        end 
        user_guess_arr
    end 

end 