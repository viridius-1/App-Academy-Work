require_relative "card.rb"
require_relative "board.rb"
require_relative "game.rb"
require_relative "human_player.rb"
require "byebug"

class ComputerPlayer 

    attr_reader :matched_cards, :name 
    attr_accessor :known_cards

    def initialize
        @name = 'Computer'
        @known_cards = {} 
        @matched_cards = {}
        @next_guess_for_match = nil 
    end

    #method returns a pair of matches based on a card's face_value 
    def fill_matches(face_value)
        matches = []
        @known_cards.each do |position, card| 
            if card == face_value 
                matches << position 
                break if matches.length == 2 
            end 
        end 
        matches 
    end 

    #method returns a pair of matched positions if there is such a pair within the @known_cards hash 
    def get_match(game)
        matches = []
        card_count = Hash.new(0)
        facevalue_position = Hash.new { |hash, key| hash[key] = [] }
        facevalue_position_count = {}

        @known_cards.each_value { |face_value| card_count[face_value] += 1 } 

        card_count.each_key do |face_value_card_count| 
            @known_cards.each { |position, face_value_known_cards| facevalue_position[face_value_card_count] << position if face_value_card_count == face_value_known_cards } 
        end 

        card_count.each { |face_value, count| facevalue_position_count[face_value] = [facevalue_position[face_value], count] } 

        facevalue_position_count.each do |face_value, position_and_count| 
            if position_and_count.last == 2 && position_and_count.first.all? { |position| game[position.first, position.last].face_up == false }
                matches = fill_matches(face_value)
                break 
            end 
        end 

        matches 
    end 

    #method returns a random guess from the available positions 
    def get_random_guess(game)
        all_board_positions = game.fill_board_positions
        available_positions = all_board_positions.select { |position| game[position.first, position.last].face_up == false } 
        available_positions.sample 
    end 

    def get_guess(game)
        guess = nil 

        if @next_guess_for_match
            guess = @next_guess_for_match
            @next_guess_for_match = nil 
        else 
            matches = get_match(game) 
            if matches.empty? 
                guess = get_random_guess(game)
            else 
                guess = matches.first 
                @next_guess_for_match = matches.last 
                @known_cards.delete(matches.first)
                @known_cards.delete(matches.last)
            end 
        end 

        guess 
    end 

    #method stores the position and value of a card 
    def receive_revealed_card(position, face_value)
        @known_cards[position] = face_value   
    end 

    #method stores positions that are matches 
    def receive_match(face_value, position1, position2)
        @matched_cards[face_value] = [position1, position2]
    end 

end