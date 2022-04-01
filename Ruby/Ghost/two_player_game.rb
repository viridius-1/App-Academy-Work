require_relative "player.rb"

class Game 

    def initialize(player1, player2)
        @player1 = Player.new(player1)
        @player2 = Player.new(player2)
        @fragment = ''
        @dictionary = {}
        @current_player = @player1 
        @losses = Hash.new(0)
    end 

    def add_ltr(ltr)
        @fragment += ltr 
    end 

    def populate_dictionary 
        data = File.readlines("dictionary.txt") 
        words_arr = data.map { |word| word.chomp }
        words_arr.each { |word| @dictionary[word] = word[0] }  
        true 
    end 

    def play_round(player1, player2)
        round_over = false 

        while !round_over 
            player_move = take_turn(@current_player) 
            add_ltr(player_move)
            if @dictionary.has_key?(@fragment)
                puts "\n#{@fragment} is a word!"
                puts "#{@current_player.name} loses the round. #{previous_player.name} wins the round."
                @losses[@current_player] += 1 
                round_over = true 
            else 
                next_player!
            end 
        end 
    end 

    def take_turn(player)
        valid_move = false 

        while !valid_move 
            puts "\nWord Fragment = #{@fragment}" if !@fragment.empty?
            if @fragment.empty?
                print "#{player.name}, enter a letter: "
            else 
                print "#{player.name}, enter a letter that keeps spelling the word fragment: "
            end 
            move = player.guess 
            if valid_play?(move) 
                valid_move = true 
            else 
                player.alert_invalid_guess 
            end 
        end 

        move 
    end 

    def valid_play?(move)
        potential_fragment = @fragment + move 
        @dictionary.each_key { |word| return true if word[0..potential_fragment.length - 1] == potential_fragment }  
        false 
    end 

    def previous_player 
        if @current_player == @player1 
            @player2 
        else 
            @player1 
        end 
    end 

    def next_player! 
        if @current_player == @player1 
            @current_player = @player2 
        else 
            @current_player = @player1
        end 
    end 

    #method translates a players losses into the appropriate GHOST substring 
    def record(player)
       ghost_hash = { 0 => '_____', 1 => 'G____', 2 => 'GH___', 3 => 'GHO__', 4 => 'GHOS_', 5 => 'GHOST' }
       ghost_hash[@losses[player]] 
    end 

    #method runs game until a player has 5 losses
    def run 
        populate_dictionary

        until game_over? 
            @fragment = ''
            display_standings 
            play_round(@current_player, previous_player)
        end 

        display_standings
        puts "#{@current_player.name} loses. #{previous_player.name} wins!" 
        puts "Game Over."
    end 

    def game_over? 
        @losses.each_value { |losses| return true if losses == 5 }  
        false 
    end 

    def display_standings 
        puts "\n\nSCOREBOARD"
        puts "The first player to get GHOST loses."
        puts "#{@current_player.name} has #{record(@current_player)}"
        puts "#{previous_player.name} has #{record(previous_player)}\n\n"
    end 

end 