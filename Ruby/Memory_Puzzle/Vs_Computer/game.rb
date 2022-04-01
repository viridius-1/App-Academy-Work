require_relative "card.rb"
require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game 

    attr_reader :game, :previous_guess

    def initialize(player)
        @game = Board.new 
        @player = HumanPlayer.new(player)
        @computer_player = ComputerPlayer.new 
        @current_player = @player 
        @previous_guess = nil 
        @previous_guess_position = nil 
        @attempts = 0
        @player_pts = 0 
        @computer_pts = 0 
    end 

    def calculate_points
        if @current_player == @player 
            @player_pts += 1 
        else 
            @computer_pts += 1 
        end 
    end 

    def switch_player
        if @current_player == @player 
            @current_player = @computer_player 
        else 
            @current_player = @player 
        end 
    end 

    def play  
        @game.set_board
        print_board
        start_time = Time.now 
        until @game.won? 
            if @current_player == @player 
                guess = @player.get_guess(@game, @player.name, @computer_player.name, @player_pts, @computer_pts)
            else 
                guess = @computer_player.get_guess(@game)
            end 
            @attempts += 1 
            store_card_in_memory(guess)   
            make_guess(guess) 
            switch_player if @attempts.even? 
        end 
        finish_game(start_time)
    end

    def store_card_in_memory(guess)
        @computer_player.receive_revealed_card(guess, @game[guess.first, guess.last].face_value)
    end 

    def finish_game(start_time)
        elapsed_time = get_time(Time.now - start_time) 
        puts "\nFinished in #{elapsed_time}."
        print_board
        if @player_pts > @computer_pts
            puts "\n#{@player.name} wins!" 
        elsif @computer_pts > @player_pts 
            puts "\n#{@computer_player.name} wins!" 
        else 
            puts "\nTie game."
        end 
        puts "Game Over."
    end 


    def make_guess(guess)
        if @previous_guess
            if @previous_guess.face_value == @game[guess.first, guess.last].face_value 
                calculate_points 
                set_card(guess, true)
                store_match(guess)  
                print_board  
                print_computer_choice(guess) if @current_player == @computer_player
                puts "Cards match! #{@current_player.name} wins a point.\n\n"
                sleep 2 
            else 
                set_card(guess, true)
                puts "\n"
                print_board
                print_computer_choice(guess) if @current_player == @computer_player
                sleep 5 
                system("clear")
                set_card(guess, false) 
                @previous_guess.face_up = false 
            end 
            print_board if @current_player == @computer_player
            @previous_guess = nil 
            @previous_guess_position = nil 
        else 
            set_card(guess, true)
            @previous_guess = @game[guess.first, guess.last]
            @previous_guess_position = guess
            puts "\n" 
            print_board
            if @current_player == @computer_player
                print_computer_choice(guess)  
                puts "\n\n" 
                sleep 2 
            end 
        end 
    end 

    def store_match(guess)
        @computer_player.receive_match(@previous_guess.face_value, guess, @previous_guess_position)
    end 

    #method sets a card face up or face down 
    def set_card(guess, value)
        @game[guess.first, guess.last].face_up = value 
    end 

    def print_computer_choice(guess)
        puts "Computer chooses #{guess}"
    end 

    def print_board 
        @game.render(@player.name, @computer_player.name, @player_pts, @computer_pts)
    end 

    #method returns a string of the time it took to play the game 
    def get_time(secs)
        minutes = 0 

        if secs < 60 
            seconds = secs 
        else 
            minutes = (secs / 60).round 
            seconds = (secs % 60).round  
        end 

        if minutes == 1 
            mins_string = "#{minutes} minute"
        else 
            mins_string = "#{minutes} minutes"
        end 

        if seconds == 1 
            secs_string = "#{seconds} second"
        else 
            secs_string = "#{seconds} seconds"
        end 

        if minutes < 1 
            secs_string 
        else 
            mins_string + " " + secs_string
        end 
    end 

end 