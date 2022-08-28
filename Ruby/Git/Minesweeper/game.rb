require_relative "board.rb"
require 'yaml'

class Minesweeper 

    attr_accessor :board_size, :leaderboard, :secs, :time_to_win_game
    attr_reader :game, :player, :saved 

    #initialize a 2D array of a 9 x 9 minesweeper board 
    def initialize
        get_player_name
        @saved = false 
        @time_to_win_game = 0 
        @secs = 0
        @leaderboard = {}

        #check if there is a saved game
        if File.file?('saved_game.yml')  
            prompt_for_saved_game
        else   
            start_game
        end 
    end 

    def get_player_name 
        print "\nEnter your name: "
        user_name = gets.chomp 
        @player = user_name 
    end 

    def introduction 
        puts "Welcome to Minesweeper!"
        puts "You win the game when you reveal all tiles that don't have a bomb."
        puts "You lose if you hit a bomb." 
        puts "Numbers on the board show the number of adjacent bombs."
        puts "To reveal a tile, enter r and then the tile's coordinates. For ex., to reveal tile 0,0 you'd enter r0,0"
        puts "If you think a tile has a bomb, then you can flag it. For ex., to flag tile 0,0 you'd enter f0,0"
        puts "To reveal a flagged tile, you must unflag it. For ex., to unflag tile 0,0 you'd enter u0,0"
        puts "To recap, enter r to reveal, f to flag, or u to unflag and then enter the tile's coordinates. Coordinates must be entered with a comma between them as shown in the above examples."
        puts "You can also save your game by entering s."
        puts "Good Luck!"
    end 

    def pick_size 
        clear 
        valid_size = false 
        while !valid_size
            puts "#{@player}, pick a size for the Minesweeper Board. Enter 1, 2, 3, or 4."
            puts "1) 9 x 9 board"
            puts "2) 10 x 10 board"
            puts "3) 15 x 15 board"
            puts "4) 20 x 20 board"
            user_size = gets.chomp 
            if ["1", "2", "3", "4"].include?(user_size) 
                valid_size = true 
            else 
                clear 
                puts "Invalid choice."
            end 
        end 
        translate_user_size_to_board_size(user_size)
    end 

    def set_board
        @game = Board.new(Array.new(board_size) { Array.new(board_size) }, board_size) 
        game.get_neighbors
        game.set_bombs 
        game.calculate_surrounding_bombs 
    end 

    def start_game 
        introduction 
        @board_size = pick_size
        set_board
    end 

    def translate_user_size_to_board_size(user_size)
        case user_size
        when '1' 
            9 
        when '2' 
            10 
        when '3' 
            15
        when '4' 
            20 
        end 
    end 

    def run 
        until game.over? || saved 
            print_board
            player_entry = get_valid_player_entry
            if is_entry_s?(player_entry)
                save 
            else 
                game.update_tile(player_entry)
            end 
        end 

        finish_game
    end 

    def get_valid_player_entry 
        valid_reveal = false 
        while !valid_reveal
            player_entry = get_entry 
            if is_entry_s?(player_entry)
                valid_reveal = true 
            else 
                position = game.get_player_entry_position(player_entry)
                if game[position.first, position.last].flagged && player_entry[0] != 'u'
                    print_board 
                    puts "Tile #{position.first},#{position.last} is flagged. To unflag this tile, enter u#{position.first},#{position.last}"
                elsif game[position.first, position.last].revealed
                    print_board
                    puts "Tile #{position.first},#{position.last} is already revealed. Choose a tile that hasn't been revealed."
                else 
                    valid_reveal = true 
                end 
            end 
        end 
        player_entry
    end 

    def finish_game 
        if saved       
            puts "Game saved."
        elsif game.won? 
            @time_to_win_game, @secs = game.get_time_to_win_game 
            print_board
            puts "Congratulations! You beat Minesweeper!"
            puts "Won in #{time_to_win_game}."
            run_leaderboard
        else 
            game.reveal_all_bombs 
            print_board
            puts "You hit a bomb. You lose. Game over."
        end 
    end 

    def leaderboard_exists?
        File.file?("leaderboard_#{board_size}x#{board_size}.yml") 
    end 

    def update_leaderboard_for_winner
        @leaderboard[player] = [time_to_win_game, secs]
    end 

    def load_leaderboard  
        @leaderboard = Psych.unsafe_load(File.read("leaderboard_#{board_size}x#{board_size}.yml"))
    end 

    def save_leaderboard 
        File.open("leaderboard_#{board_size}x#{board_size}.yml", "w") { |file| file.write(leaderboard.to_yaml)}
    end 

    def sort_leaderboard 
        leaderboard_arr = leaderboard.sort_by { |name, win_data| win_data[1] }
        leaderboard_arr[0..9]
    end 

    def revise_leaderboard(leaderboard_arr)
        leaderboard_arr.each { |leader| @leaderboard[leader[0]] = [leader[1][0], leader[1][1]] } 
    end 

    def render_leaderboard(leaderboard_arr)
        puts "\nLEADERBOARD"
        leaderboard_arr.each_with_index { |leader, idx| puts "#{idx + 1}) #{leader[0]} - #{leader[1][0]}" }
        true 
    end 

    def run_leaderboard
        load_leaderboard if leaderboard_exists? 
        update_leaderboard_for_winner
        leaderboard_arr = sort_leaderboard
        revise_leaderboard(leaderboard_arr) 
        save_leaderboard
        render_leaderboard(leaderboard_arr)
    end 

    def print_board 
        system("clear")
        game.render 
    end 

    def clear 
        system("clear")
    end 

    def is_entry_s?(entry)
        entry == 's'
    end 

    def get_entry
        valid_entry = false 
        while !valid_entry
            puts "#{player}, make an entry or enter s to save game."
            print "Entry: "
            user_entry = gets.chomp.downcase  
            if valid_user_entry?(user_entry) 
                valid_entry = true 
            else 
                print_board
                puts "Invalid entry. Please make a valid entry."
                puts "Example to reveal tile 0,0: r0,0"
                puts "Example to flag tile 0,0: f0,0"
                puts "Example to unflag tile 0,0: u0,0"
            end 
        end 
        user_entry
    end 

    def valid_user_entry?(user_entry)
        return true if is_entry_s?(user_entry)
        return false if user_entry[0] != 'r' && user_entry[0] != 'f' && user_entry[0] != 'u'
        user_entry = user_entry[1..-1]
        return false if !user_entry.include?(',')
        pos_arr = user_entry.split(',')
        pos_arr.all? { |el| ('0'..String(game.board_size - 1)).include?(el) }
    end 

    def save 
        game.update_time 
        File.open("saved_game.yml", "w") { |file| file.write(game.to_yaml)}
        @saved = true
    end 

    def prompt_for_saved_game
        puts "Do you want to continue your saved game? Enter y for yes or any other key for no."
        user_choice = gets.chomp.downcase 
        if user_choice == 'y'
            @game = Psych.unsafe_load(File.read("saved_game.yml"))
            @saved = false 
            game.set_start_time
        else   
            start_game
        end 
    end 

end 

game = Minesweeper.new 
game.run
