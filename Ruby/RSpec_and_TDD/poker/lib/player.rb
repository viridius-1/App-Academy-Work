require_relative 'hand'
require_relative 'game'
require 'byebug'

class Player 

    attr_reader :deck, :folded_players, :hand, :name, :player_with_highest_bet
    attr_accessor :able_to_see, :able_to_raise, :alive, :alive_players, :already_bet, :bet, :chips, :fold, :pot, :raise, :round_current_bet  

    def initialize(name, deck)
        @deck = deck 
        @pot = nil  
        @round_current_bet = nil 
        @name = name 
        @chips = 10 
        @alive = true 
    end 

    def deal_cards
        @hand = Hand.new(deck)
    end 

    def reset_bet_data
        @bet = 0
        @raise = 0 
        @fold = false
        @able_to_see = false  
        @able_to_raise = false 
        @already_bet = false 
    end 

    def set_already_bet
        @already_bet = true 
    end 

    def set_alive_players(alive_players)
        @alive_players = alive_players
    end 

    def set_folded_players(folded_players)
        @folded_players = folded_players
    end 

    def set_player_with_highest_bet(player_with_highest_bet)
        @player_with_highest_bet = player_with_highest_bet
    end 

    def evaluate_able_to_see 
        if round_current_bet > bet 
            @able_to_see = true if chips + bet >= round_current_bet
        end         
    end 

    def evaluate_able_to_raise
        raise_floor = round_current_bet + 1 
        @able_to_raise = true if chips + bet >= raise_floor
    end 

    def must_fold? 
        !able_to_see && !able_to_raise
    end 

    def get_player_choice_possibilities
        player_choice_possibilities = ['f']
        player_choice_possibilities << 's' if able_to_see
        player_choice_possibilities << 'r' if able_to_raise 
        player_choice_possibilities
    end 

    def get_first_player_choice
        valid_choice = false 

        while !valid_choice
            render 
            puts "#{name}, enter B to bet or F to fold."
            player_choice = gets.chomp.downcase 
            if player_choice == 'b' || player_choice == 'f'
                valid_choice = true 
            else 
                invalid_choice
            end 
        end 

        player_choice
    end 

    def get_next_player_choice
        valid_choice = false 
        while !valid_choice
            render 
            puts "#{name}, make a selection."
            puts "Enter S to see." if able_to_see
            puts "Enter R to raise." if able_to_raise
            puts "Enter F to fold."
            player_choice = gets.chomp.downcase 
            player_choice_possibilities = get_player_choice_possibilities 
            if player_choice_possibilities.include?(player_choice)
                valid_choice = true 
            else 
                invalid_choice
            end 
        end 

        player_choice
    end 

    def illegal_characters?(user_entry)
        user_entry.split('').any? { |char| char.ord < 48 || char.ord > 57 }
    end 

    def legal_amount?(amount)
        if illegal_characters?(amount) || amount.empty?
            invalid_amount
            return false 
        elsif Integer(amount) == 0 
            puts "Invalid entry. You can't bet 0 chips. You have #{chips} chips to bet. Press return/enter to continue."
            gets 
            return false 
        elsif Integer(amount) > chips
            invalid_amount
            return false 
        end 
  
        true 
    end 

    def get_amount
        valid_bet = false 

        while !valid_bet 
            render 
            puts "#{name}, how much do you want to bet?"
            user_amount = gets.chomp
            valid_bet = true if legal_amount?(user_amount)
        end 

        Integer(user_amount)
    end 

    #method is used when player is taking the first turn in a bet round 
    def make_first_turn(alive_players)
        reset_bet_data
        set_already_bet
        set_alive_players(alive_players)

        player_choice = get_first_player_choice
        if player_choice == 'b'
            @bet = get_amount  
            @chips -= bet 
            bet 
        else 
            fold_player
        end 
    end 

    #method is used when player is taking a subsequent turn in a bet round 
    def make_next_turn(alive_players, folded_players, player_with_highest_bet)
        set_alive_players(alive_players)
        set_folded_players(folded_players)
        set_player_with_highest_bet(player_with_highest_bet)
        reset_bet_data if !already_bet
        set_already_bet
        evaluate_able_to_see
        evaluate_able_to_raise

        if must_fold? 
            @fold = true 
            puts "#{name}, you don't have enough chips to see or raise. You have folded."
            puts "Press enter/return to continue."
            gets 
            'f'
        else 
            next_turn_decision 
        end 
    end 

    def next_turn_decision
        player_choice = get_next_player_choice

        if player_choice == 's'
            see_amount = round_current_bet - bet 
            @bet += see_amount
            @chips -= see_amount
            ['s', see_amount]
        elsif player_choice == 'r'
            @raise = get_amount
            @bet += raise 
            @chips -= raise 
            ['r', bet]
        elsif player_choice == 'f'
            fold_player 
        end 
    end 

    def fold_player 
        @fold = true 
        puts "#{name}, you have folded."
        ['f', 0] 
    end 

    def receive_chips(amount)
        @chips += amount
    end 

    def discard(idx) 
        @hand.remove_card(idx)
    end 

    def receive_card(card)
        @hand.add_card(card)
    end 

    def invalid_choice
        puts "Invalid choice. Press return/enter to continue."
        gets 
    end 

    def invalid_amount 
        puts "Invalid entry. Please enter a number less than or equal to the chips you have. You have #{chips} chips to bet. Press return/enter to continue."
        gets 
    end 

    def render 
        clear 
        show_info
    end 

    def show_info
        puts "POKER"
        puts "Players with Chips - #{alive_players.join(', ')}"
        puts "Folded Players - #{folded_players.join(', ')}" if folded_players
        puts "Pot - #{pot}" 
        puts "Player with Highest Bet this Round - #{player_with_highest_bet}"
        puts "Current Bet this Round - #{round_current_bet}"
        puts "Your Bet this Round - #{bet}"
        puts "Your Chips - #{chips}"
        show_hand
    end 

    def show_hand
        print "\nHand: "
        hand.hand.each { |card| print "#{card.symbol} " } 
        puts "\n"
    end 

    def clear 
        system("clear")
    end 
 
end 