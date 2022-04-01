require_relative "card.rb"
require_relative "game.rb"
require_relative "human_player.rb"
require "byebug"

class Board 

    attr_reader :all_board_positions, :board, :cards, :chosen_cards, :deck, :position1, :position2, :used_board_positions

    def initialize 
        @board = Array.new(4) { Array.new(4) }
        @all_board_positions = []
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
        @cards.each { |card| @deck << [Card.new(card), Card.new(card)] }  
    end 

    def get_card 
        @deck.sample 
    end 

    def choose_cards 
        until @chosen_cards.length == 8 
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
        self[@position1.first, @position1.last] == nil && self[@position2.first, @position2.last] == nil && @position1 != @position2
    end 

    def choose_position1_and_position2 
        @position1 = @all_board_positions.sample 
        @position2 = @all_board_positions.sample
    end 

    def choose_board_positions
        valid_board_choice = false 
        while !valid_board_choice
            choose_position1_and_position2
            valid_board_choice = true if valid_board_choice?
        end 
        @all_board_positions.delete(@position1)
        @all_board_positions.delete(@position2)
        [@position1, @position2]
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
    end 

    def reveal(guessed_position)
        self[guessed_position.first, guessed_position.last].reveal 
        self[guessed_position.first, guessed_position.last].face_value 
    end 

    #method prints the board 
    def render(name, computer_name, player_pts, computer_pts) 
        print "#{name}"
        print "#{computer_name}\n".rjust(15)
        print player_pts
        print "#{computer_pts}\n".rjust(18)
        print "MEMORY PUZZLE\n".rjust(17)
        print "0".rjust(3)
        print "1".rjust(5)
        print "2".rjust(5)
        print "3\n".rjust(6)
        @board.each_with_index do |row, row_idx|  
            print row_idx 
            row.each do |card| 
                if card.display.length == 1 
                    print " #{card.display}   "
                elsif card.display.length == 2
                    print " #{card.display}  "
                else 
                    print " #{card.display} "
                end 
            end 
            puts "\n"
        end 
        nil 
    end 

    #method returns true if all cards have been revealed 
    def won? 
        @board.each do |row| 
            row.each { |card| return false if card.face_up == false }
        end 
        true 
    end 

end 