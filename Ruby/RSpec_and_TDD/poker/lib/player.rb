require_relative 'hand'
require_relative 'game'
require 'byebug'

class Player 

    attr_reader :alive_players, :deck, :hand, :name, :pot, :round_current_bet 
    attr_accessor :alive, :bet, :chips, :fold, :see  

    def initialize(name, deck, pot, round_current_bet)
        @deck = deck 
        @pot = pot 
        @round_current_bet = round_current_bet
        @name = name 
        @chips = 10 
        @bet = 0
        @see = false 
        @fold = false
        @alive = true 
    end 

    def deal_cards
        @hand = Hand.new(deck)
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
                puts "Invalid choice."
            end 
        end 

        player_choice
    end 

    def illegal_characters?(bet)
        bet.split('').any? { |char| char.ord < 48 || char.ord > 57 }
    end 


    def legal_bet?(bet)
        if illegal_characters?(bet)
            puts "Invalid entry."
            return false 
        elsif Integer(bet) > chips 
            puts "Invalid entry. You only have #{chips} chips to bet."
            return false 
        end 
  
        true 
    end 

    def get_player_bet
        valid_bet = false 

        while !valid_bet 
            render 
            puts "#{name}, how much do you want to bet?"
            user_bet = gets.chomp
            valid_bet = true if legal_bet?(user_bet)
        end 

        Integer(user_bet)
    end 

    def make_first_turn(alive_players)
        @alive_players = alive_players
        player_choice = get_first_player_choice
        if player_choice == 'b'
            @bet = get_player_bet 
            @chips -= bet 
            bet 
        else 
            puts "You have folded."
            @fold = true 
            'f'
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

    def render 
        clear 
        show_info
    end 

    def show_info
        puts "POKER"
        puts "Alive Players - #{alive_players.join(', ')}"
        puts "Pot - #{pot}" 
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