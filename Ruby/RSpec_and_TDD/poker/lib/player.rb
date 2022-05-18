require_relative 'hand'
require_relative 'game'
require 'byebug'

class Player 

    attr_reader :card_letters, :deck, :folded_players, :name, :player_with_highest_bet, :ten_card_at_idx_0_in_exchange_print
    attr_accessor :able_to_see, :able_to_raise, :alive, :alive_players, :already_bet, :bet, :cards_to_exchange, :chips, :fold, :hand, :hand_copy, :pot, :raise, :round_current_bet  

    def initialize(name, deck)
        @deck = deck 
        @pot = nil  
        @round_current_bet = nil 
        @name = name 
        @chips = 10 
        @alive = true 
        @card_letters = ['v', 'w', 'x', 'y', 'z', 'h']
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

    def reset_hand_copy_and_cards_to_exchange 
        @hand_copy = hand.hand.dup
        @cards_to_exchange = []
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
            show_hand
            puts "#{name}, enter B to bet or F to fold."
            player_choice = gets.chomp.downcase 
            if player_choice == 'b' || player_choice == 'f'
                valid_choice = true 
            else 
                invalid_entry
            end 
        end 

        player_choice
    end 

    def get_next_player_choice
        valid_choice = false 
        while !valid_choice
            render 
            show_hand
            puts "#{name}, make a selection."
            puts "Enter S to see." if able_to_see
            puts "Enter R to raise." if able_to_raise
            puts "Enter F to fold."
            player_choice = gets.chomp.downcase 
            player_choice_possibilities = get_player_choice_possibilities 
            if player_choice_possibilities.include?(player_choice)
                valid_choice = true 
            else 
                invalid_entry
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
            show_hand
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

    def exchange_or_reset
        ['e', 'r']
    end 

    def valid_entry_for_3_or_4_cards?(entry)
        range_end = hand_copy.length - 1 
        card_letters[0..range_end].include?(entry) || exchange_or_reset.include?(entry)
    end 

    def valid_user_exchange_choice?(entry)
        if hand_copy.length == 5 
            return true if card_letters.include?(entry) 
        elsif hand_copy.length > 2 
            return true if valid_entry_for_3_or_4_cards?(entry)
        else 
            return true if exchange_or_reset.include?(entry)
        end 

        false 
    end 

    def get_user_exchange_choice
        valid_choice = false
        while !valid_choice
            clear 
            exchange_cards_prompt
            user_choice = gets.chomp.downcase
            if valid_user_exchange_choice?(user_choice)
                valid_choice = true
            else 
                invalid_entry
            end 
        end 
        user_choice
    end 

    def delete_cards_to_exchange
        cards_to_exchange.each { |card| hand.hand.delete(card) } 
    end 

    def deal_new_cards
        num_cards_to_deal = cards_to_exchange.length 
        new_cards = deck.deal(num_cards_to_deal)
        new_cards.each { |card| @hand.hand << card }
    end 

    def discard_and_deal
        delete_cards_to_exchange
        deal_new_cards
    end 

    def update_cards_to_exchange(choice)
        hand_copy_index = card_letters.index(choice)
        selected_card = hand_copy.delete_at(hand_copy_index)
        @cards_to_exchange << selected_card
    end 

    def exchange_cards 
        reset_hand_copy_and_cards_to_exchange

        exchange_cards = false 
        while !exchange_cards
            user_exchange_choice = get_user_exchange_choice 
            if user_exchange_choice == 'h'
                exchange_cards = true 
            elsif user_exchange_choice == 'e'
                discard_and_deal
                new_hand_prompt
                exchange_cards = true 
            elsif user_exchange_choice == 'r' 
                reset_hand_copy_and_cards_to_exchange
            else 
                update_cards_to_exchange(user_exchange_choice)
            end 
        end 
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

    def fold_player 
        @fold = true 
        puts "#{name}, you have folded."
        ['f', 0] 
    end 

    def invalid_entry
        puts "Invalid entry. Press return/enter to continue."
        gets 
    end 

    def invalid_amount 
        puts "Invalid entry. Please enter a number less than or equal to the chips you have. You have #{chips} chips to bet. Press return/enter to continue."
        gets 
    end 

    def render
        clear 
        show_bet_info
    end 

    def show_bet_info
        puts "POKER"
        puts "Players with Chips - #{alive_players.join(', ')}"
        puts "Folded Players - #{folded_players.join(', ')}" if folded_players
        puts "Pot - #{pot}" 
        puts "Player with Highest Bet this Round - #{player_with_highest_bet}"
        puts "Current Bet this Round - #{round_current_bet}"
        puts "Your Bet this Round - #{bet}"
        puts "Your Chips - #{chips}"
        new_line
    end 

    def show_hand
        print "Hand: "
        hand.hand.each { |card| print "#{card.symbol}  " } 
        new_line
    end 

    def card_in_hand_with_10_card_at_idx_0?
        ten_card_at_idx_0_in_exchange_print && !['v', 'w', 'x', 'y', 'z'].include?(object)
    end 

    def ten_card_at_idx_0?(card, idx)
        idx == 0 && card.type == "10"
    end 

    def exchange_cards_prompt 
        render 
        show_hand_for_exchange
        show_cards_for_exchange
        exchange_prompt 
    end 

    def new_hand_prompt
        render 
        puts "#{name}, here's your new hand. Press return/enter to continue."
        show_hand
        gets 
    end 

    def exchange_print(object, idx)
        if idx == 0 
            print object 
        elsif idx == 1 && card_in_hand_with_10_card_at_idx_0?
            print "   #{object}"
        else 
            print object.rjust(6)
        end 
    end 

    def print_cards_for_exchange 
        @ten_card_at_idx_0_in_exchange_print = false 
        hand_copy.each_with_index do |card, idx| 
            exchange_print(card.symbol, idx) 
            @ten_card_at_idx_0_in_exchange_print = true if ten_card_at_idx_0?(card, idx)
        end 
    end 

    def print_letters_for_exchange
        last_idx_needed = hand_copy.length - 1 
        current_card_letters = card_letters[0..last_idx_needed]
        current_card_letters.each_with_index { |letter, idx| exchange_print(letter, idx) } 
        new_line 
    end 

    def show_hand_for_exchange 
        print "Hand".rjust(17)
        new_line
        print_letters_for_exchange 
        print_cards_for_exchange
    end 

    def exchange_prompt
        puts "\n\n#{name}:"
        if hand_copy.length == 5 
            enter_letter_message
            puts "Enter H to hold these cards"
        elsif hand_copy.length > 2  
            enter_letter_message
            enter_e_enter_r_message
        else 
            enter_e_enter_r_message
        end 
    end 

    def show_cards_for_exchange 
        print "\n\nCards to Exchange: "
        cards_to_exchange.each { |card| print "#{card.symbol}  " }
    end 

    def enter_letter_message
        puts "Enter letter above card to mark it for exchange. You can exchange 3 cards."
    end 

    def enter_e_enter_r_message
        puts "Enter E to exchange cards. You can exchange 3 cards." 
        puts "Enter R to reset cards"
    end 

    def new_line 
        puts "\n"
    end 

    def clear 
        system("clear")
    end 
 
end 