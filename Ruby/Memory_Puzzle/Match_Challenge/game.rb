require_relative "card.rb"
require_relative "board.rb"
require_relative "human_player.rb"

class Game 

    attr_reader :game, :previous_guess

    def self.valid_match_choice?(user_match_choice)
        return false if user_match_choice.length != 1 
        user_match_choice.ord >= 50 && user_match_choice.ord <= 53 
    end 

    def initialize(player, board_size, turns_allowed, matches, bombs)
        @game = Board.new(board_size, matches, bombs) 
        @matches = matches 
        @player = HumanPlayer.new(player, board_size)
        @guesses = [] 
        @turns = 0 
        @turns_allowed = turns_allowed
        @bombs = bombs 
        @bomb_hits = 0 
    end 

    def clear 
        system("clear")
    end 

    def play  
        @game.set_board
        print_board(true)
        until @game.won? || @game.lost?(@turns, @turns_allowed, @bomb_hits)  
            guess = @player.get_guess(@game, @player.name, @turns, @turns_allowed, @bomb_hits)
            clear 
            make_guess(guess) 
        end 
        finish_game
    end

    def finish_game
        puts "\n"
        print_board
        if @game.won? 
            puts "Congratulations! You win!" 
        else 
            puts "You hit all the bombs." if @bomb_hits == @bombs  
            puts "You lose." 
        end 
        puts "Game Over."
    end 

    def make_guess(guess)
        if bomb_hit?(guess)
            set_card_face_up(guess)
            @bomb_hits += 1  
            print_board
            puts "You hit a bomb!"
            clear if @bomb_hits == @bombs 
        elsif @guesses.empty? 
            set_card_face_up(guess)
            record_guess(guess) 
            clear 
            print_board
        elsif @game[guess.first, guess.last].face_value != @guesses[-1].face_value
            set_card_face_up(guess)
            print_board
            sleep 5 
            clear
            set_card_face_down(guess) 
            @guesses.each { |card| card.hide } 
            @guesses = []
            @turns += 1 
            print_board
        elsif @guesses.length + 1 == @matches && @game[guess.first, guess.last].face_value == @guesses[-1].face_value  
            @guesses = []
            set_card_face_up(guess)
            print_board
            puts "Cards match!\n"
            sleep 2 
            clear 
            print_board
        else #cards match. still 1 or more guesses remaining.    
            set_card_face_up(guess)
            clear 
            print_board
            record_guess(guess)
        end 
    end 

    def bomb_hit?(guess)
        @game[guess.first, guess.last].face_value == "**"
    end 

    def record_guess(guess)
        @guesses << @game[guess.first, guess.last]
    end 

    def set_card_face_up(guess)
        @game[guess.first, guess.last].reveal 
    end

    def set_card_face_down(guess)
        @game[guess.first, guess.last].hide 
    end

    def print_board(starting=nil)
        puts "\n"
        @game.render(@turns, @turns_allowed, @bomb_hits, starting)
    end 

    if __FILE__ == $PROGRAM_NAME
        print "Enter your name: "
        user_name = gets.chomp 
        puts "\nWelcome to Memory Puzzle Challenge, #{user_name}!" 
        puts "You will have a specified number of turns to match cards. If you complete the puzzle before the allowed number of turns, you win!"
        puts "There are bombs in the board. The bombs will be shown for 5 seconds at the beginning of the game. If you hit all the bombs, you lose.\n\n"
       
        valid_match = false 
        while !valid_match
            print "How many cards do you want to match? Enter 2, 3, 4, or 5. "
            user_match_choice = gets.chomp 
            if self.valid_match_choice?(user_match_choice) 
                valid_match = true 
            else 
                puts "\nInvalid choice."
            end 
        end 
        
        user_match_choice = user_match_choice.to_i 
        board_size = user_match_choice * 2 
        turns_allowed = (board_size ** 2) + 4 
        bombs = user_match_choice 

        g = Game.new(user_name, board_size, turns_allowed, user_match_choice, bombs)
        puts "\n" 
        g.play
    end 

end 