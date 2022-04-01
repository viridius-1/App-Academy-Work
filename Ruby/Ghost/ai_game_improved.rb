require_relative "player.rb"
require_relative "aiplayer_improved.rb"
require "byebug"

class Game 

    def initialize(*players)
        @players = players.each.map { |player| Player.new(player) } 
        @fragment = ''
        @dictionary = {}
    end 

    def add_aiplayer
        @players << AiPlayer.new 
    end 

    def set_current_player_to_first_player
        @current_player = @players.first 
    end 

    def set_losses_hash
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

    def play_round(players)
        round_over = false 

        while !round_over 
            player_move = take_turn(@current_player) 
            add_ltr(player_move)
            if @dictionary.has_key?(@fragment)
                puts "\n#{@fragment} is a word!"
                puts "#{@current_player.name} loses the round."
                @losses[@current_player] += 1 
                round_over = true 
            else 
                next_player!
            end 
        end 
    end 

    def take_turn(player)
        if player.class == Player 
            valid_move = false 

            while !valid_move 
                puts "\nWord Fragment = #{@fragment}" if !@fragment.empty?
                if @fragment.empty?
                    print "#{player.name}, enter a letter: "
                else 
                    print "#{player.name}, enter a letter that keeps spelling the word fragment: "
                end 
                move = player.guess #Human player move 
                if valid_play?(move) 
                    valid_move = true 
                else 
                    player.alert_invalid_guess 
                end 
            end 
        else  
            move = player.guess(@fragment, @dictionary, @players.length - 1) #AiPlayer move 
            puts "\nWord Fragment = #{@fragment}"
            print "#{@current_player.name} chooses: #{move}\n"
        end 

        move 
    end 

    def valid_play?(move)
        potential_fragment = @fragment + move 
        @dictionary.each_key { |word| return true if word[0..potential_fragment.length - 1] == potential_fragment }  
        false 
    end 

    def next_player! 
        player_idx = @players.index(@current_player)
        if player_idx < @players.length - 1 
            @current_player = @players[player_idx + 1]
        else 
            set_current_player_to_first_player 
        end 
    end 

    #method eliminates current player from future rounds 
    def remove_player
        @players.delete(@current_player)
    end 

    #method translates a players losses into the appropriate GHOST substring 
    def record(player)
       ghost_hash = { 0 => '_____', 1 => 'G____', 2 => 'GH___', 3 => 'GHO__', 4 => 'GHOS_', 5 => 'GHOST' }
       ghost_hash[@losses[player]] 
    end 

    #method runs until there is only 1 player left 
    def run 
        populate_dictionary
        add_aiplayer 
        
        until game_over? 
            set_losses_hash
            until round_over? 
                @fragment = ''
                set_current_player_to_first_player
                display_standings 
                play_round(@players)
            end 
            puts "\n#{@current_player.name} has #{record(@current_player)}. #{@current_player.name} is disqualified."
            remove_player
        end 

        display_standings
        puts "#{@players.first.name} wins!" 
        puts "Game Over."
    end 

    def round_over? 
        @losses.each_value { |losses| return true if losses == 5 }  
        false 
    end 

    def game_over? 
        @players.length == 1 
    end 

    def display_standings 
        puts "\n\nSCOREBOARD"
        puts "A player is disqualified when obtaining GHOST. The last player standing wins."
        @players.each { |player| puts "#{player.name} has #{record(player)}" } 
        puts "\n\n"
    end 

end 