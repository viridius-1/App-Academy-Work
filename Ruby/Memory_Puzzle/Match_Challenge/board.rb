require_relative "card.rb"
require_relative "game.rb"
require_relative "human_player.rb"
require "byebug"

class Board 

    attr_reader :all_board_positions, :board, :board_positions, :cards, :chosen_cards, :deck, :position1, :position2, :used_board_positions

    def initialize(board_size, matches, bombs) 
        @board_size = board_size 
        @matches = matches 
        @bombs = bombs 
        @board = Array.new(board_size) { Array.new(board_size) }
        @all_board_positions = []
        @board_positions = []
        @position1 = nil 
        @position2 = nil 
        @chosen_cards = []
        @deck = [] 
        @cards = [ '2S', '3S', '4S', '5S', '6S', '7S', '8S', '9S', '10S', 'JS', 'QS', 'KS', 'AS', 
        '2H', '3H', '4H', '5H', '6H', '7H', '8H', '9H', '10H', 'JH', 'QH', 'KH', 'AH', 
        '2D', '3D', '4D', '5D', '6D', '7D', '8D', '9D', '10D', 'JD', 'QD', 'KD', 'AD', 
        '2C', '3C', '4C', '5C', '6C', '7C', '8C', '9C', '10C', 'JC', 'QC', 'KC', 'AC']
    end 

    def load_deck 
        @cards.each do |card| 
            card_arr = []
            @matches.times { card_arr << Card.new(card) }
            @deck << card_arr 
        end  
    end 

    def get_card 
        @deck.sample 
    end 

    def choose_cards 
        until @chosen_cards.length == ((@board_size ** 2) - @bombs) / @matches   
            card = get_card 
            @chosen_cards << card if !@chosen_cards.include?(card)
        end 
    end 

    def fill_board_positions
        @all_board_positions = []
        @board.each_with_index do |row, row_idx| 
            row.each_with_index { |space, col_idx| @all_board_positions << [row_idx, col_idx] } 
        end 
        @all_board_positions
    end 

    def valid_board_choice? 
        @board_positions.each { |position| return false if self[position.first, position.last] != nil } 
        @board_positions.all? { |position| @board_positions.count(position) == 1 }
    end 

    def choose_positions
        @board_positions = []
        @matches.times { @board_positions << @all_board_positions.sample }
    end 

    def choose_board_positions
        valid_board_choice = false 
        while !valid_board_choice
            choose_positions
            valid_board_choice = true if valid_board_choice?
        end 
        @board_positions.each { |position| @all_board_positions.delete(position) } 
        @board_positions
    end 

    def set_bombs
        @all_board_positions.each do |board_position| 
            self[board_position.first, board_position.last] = Card.new("**") if self[board_position.first, board_position.last] == nil 
        end 
    end 

    def [](row, col)
        @board[row][col]
    end 

    def []=(row, col, card)
        @board[row][col] = card 
    end 

    def set_board 
        fill_board_positions
        load_deck 
        choose_cards 
        @chosen_cards.each do |card|
            board_positions = choose_board_positions 
            board_positions.each_with_index { |position, idx| self[position.first, position.last] = card[idx] } 
        end 
        set_bombs 
    end 

    def reveal(guessed_position)
        self[guessed_position.first, guessed_position.last].reveal 
        self[guessed_position.first, guessed_position.last].face_value 
    end 

    #method prints the board 
    def render(turns, turns_allowed, bomb_hits, starting=nil) 
        puts "SHOWING BOMBS........." if starting
        puts "MEMORY PUZZLE - MATCH #{@matches}"
        puts "#{turns_allowed} turns allowed."
        puts "Turns - #{turns}" 
        puts "Turns Remaining - #{turns_allowed - turns}"
        puts "Bombs - #{@bombs}"
        puts "Bomb Hits - #{bomb_hits}" 
        print "  0"
        (1..@board_size - 1).each { |i| print "    #{i}"}
        puts "\n"
        @board.each_with_index do |row, row_idx|  
            print row_idx 
            row.each do |card| 
                if card.face_value == "**"
                    if starting || card.face_up == true 
                        print " #{card.face_value}  " 
                    else   
                        print " -   "
                    end 
                elsif card.display.length == 1 
                    print " #{card.display}   "
                elsif card.display.length == 2
                    print " #{card.display}  "
                else 
                    print " #{card.display} "
                end 
            end 
            puts "\n"
        end 
        if starting 
            sleep 5 
            system("clear")
            render(turns, turns_allowed, bomb_hits) 
        end 
        nil 
    end 

    #method returns true if all cards have been revealed 
    def won? 
        @board.each do |row| 
            row.each do |card| 
                if card.face_value == '**'
                    next 
                else 
                    return false if card.face_up == false 
                end 
            end 
        end 
        true 
    end 

    def lost?(turns, turns_allowed, bomb_hits)
        return true if bomb_hits == @bombs 
        turns == turns_allowed
    end 

end 