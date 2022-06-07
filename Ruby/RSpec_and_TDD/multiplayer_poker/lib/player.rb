require_relative 'hand'
require_relative 'game'

class Player 

    attr_reader :alive_players_names, :card_letters, :deck, :max_bet_when_2_players_left, :max_of_other_players_chips, :name, :other_player, :ten_card_at_idx_0_in_exchange_print
    attr_accessor :able_to_call, :able_to_raise, :able_to_stay, :alive, :alive_players, :already_bet, :bet, :bet_round1_finished, :cards_to_exchange, :chips, :eliminated_players, :eliminated_players_names, :fold, :folded_players, :hand, :hand_copy, :players, :player_with_highest_bet, :pot, :round_current_bet  

    def initialize(name, deck)
        @deck = deck 
        @pot = nil  
        @round_current_bet = nil 
        @name = name 
        @chips = 10 
        @alive = true 
        reset_already_bet
        @bet_round1_finished = false 
        @card_letters = ['v', 'w', 'x', 'y', 'z', 'h']
    end 

    def deal_cards
        @hand = Hand.new(deck)
    end 

    def reset_bet_data
        if !bet_round1_finished
            reset_data_for_round1 
        else      
            reset_data_for_round2 
        end 
    end 

    def toggle_bet_round1_finished_and_already_bet
        @already_bet = already_bet == false ? true : false 
        @bet_round1_finished = bet_round1_finished == false ? true : false 
    end 

    def no_chips? 
        chips == 0 
    end 

    def calculate_hand 
        hand.calculate
    end 

    def player_hand    
        hand.hand
    end 

    def hand_values 
        @hand.values 
    end 

    def hand_values=(array)
        @hand.values = array
    end

    def suit_of_first_card_in_hand
        player_hand[0].suit
    end 

    def value_of_four_of_a_kind
        hand.four_of_a_kind_value
    end 

    def value_of_three_of_a_kind
        hand.three_of_a_kind_value
    end 

    #method is used when player is taking the first turn in the 1st bet round 
    def make_first_turn(alive_players, eliminated_players)
        reset_bet_data
        set_alive_and_eliminated_players_data(alive_players, eliminated_players) 
        set_player_with_highest_bet(nil)
        first_turn_decision 
    end 

    #method is used when player is taking a subsequent turn in a bet round 
    def make_next_turn(alive_players, eliminated_players, folded_players, player_with_highest_bet)
        set_alive_and_eliminated_players_data(alive_players, eliminated_players)
        set_folded_players(folded_players)
        set_player_with_highest_bet(player_with_highest_bet)
        reset_bet_data
        reset_able_to_stay_able_to_call_able_to_raise
        evaluate_able_to_stay_able_to_call_able_to_raise
        next_turn_decision_or_fold
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

    private 

    def reset_data_for_round1
        if !already_bet
            set_already_bet
            reset_fold
            reset_folded_players
            reset_bet
            reset_able_to_stay_able_to_call_able_to_raise
            reset_pot 
            reset_round_current_bet
        end 
    end 

    def reset_data_for_round2
        if !already_bet
            set_already_bet
            reset_able_to_stay_able_to_call_able_to_raise
        end 
    end 

    def reset_pot 
        @pot = 0 
    end 

    def reset_round_current_bet
        @round_current_bet = 0 
    end 

    def reset_already_bet 
        @already_bet = false 
    end 

    def reset_fold
        @fold = false
    end 

    def reset_folded_players
        @folded_players = []
    end 

    def reset_bet 
        @bet = 0
    end 

    def reset_able_to_stay_able_to_call_able_to_raise
        @able_to_stay = false
        @able_to_call = false  
        @able_to_raise = false 
    end 

    def reset_hand_copy_and_cards_to_exchange 
        @hand_copy = hand.hand.dup
        @cards_to_exchange = []
    end 

    def set_already_bet
        @already_bet = true 
    end 

    def set_alive_and_eliminated_players_data(alive_players, eliminated_players) 
        set_alive_players(alive_players)
        set_eliminated_players(eliminated_players)
        set_names(alive_players)
        set_names(eliminated_players)
    end 

    def set_alive_players(alive_players)
        @alive_players = alive_players
    end 

    def set_eliminated_players(eliminated_players)
        @eliminated_players = eliminated_players
    end 

    def set_names(players)
        @players = []
        players.each { |player| @players << player.name }
    end 

    def set_folded_players(folded_players)
        @folded_players = folded_players
    end 

    def set_player_with_highest_bet(player_with_highest_bet)
        @player_with_highest_bet = player_with_highest_bet
    end 

    def set_other_player
        @other_player = get_other_player 
    end 

    def set_max_bet_when_2_players_left
        @max_bet_when_2_players_left = (other_player.chips + round_current_bet) - bet 
    end 

    def set_max_of_other_players_chips
        chips_of_other_players = []
        alive_players.each { |alive_player| chips_of_other_players << alive_player.chips if self != alive_player && !alive_player.fold }
        @max_of_other_players_chips = chips_of_other_players.max 
    end 

    def get_players_not_folded 
        players_not_folded = []
        alive_players.each { |player| players_not_folded << player unless player.fold }
        players_not_folded
    end 

    def get_other_player 
        players_not_folded = get_players_not_folded
        self == players_not_folded[0] ? players_not_folded[1] : players_not_folded[0]
    end 

    def evaluate_able_to_stay_able_to_call_able_to_raise
        evaluate_able_to_stay 
        evaluate_able_to_call
        evaluate_able_to_raise
    end 

    def evaluate_able_to_stay
        @able_to_stay = true if bet == round_current_bet
    end 

    def evaluate_able_to_call 
        if no_chips?     
            return
        elsif round_current_bet > bet 
            @able_to_call = true if chips + bet >= round_current_bet
        end 
    end 

    def evaluate_able_to_raise
        if no_chips? 
            return 
        elsif chips + bet > round_current_bet 
            if two_players_in_bet_round? 
                set_other_player
                @able_to_raise = true if other_player.chips > 0 
            else 
                set_max_of_other_players_chips
                return if max_of_other_players_chips == nil 
                @able_to_raise = true if max_of_other_players_chips > 0 
            end 
        end 
    end 

    def players_in_bet_round
        players_in_round = 0  
        alive_players.each { |player| players_in_round += 1 unless player.fold }
        players_in_round 
    end 

    def three_or_four_players_in_bet_round?
        players_in_bet_round == 3 || players_in_bet_round == 4 
    end 

    def two_players_in_bet_round?
        players_in_bet_round == 2 
    end 

    def invalid_bet_when_3_or_4_players_left?(amount)
        if three_or_four_players_in_bet_round? 
            set_max_of_other_players_chips
            return true if Integer(amount) > max_of_other_players_chips
        end 
        false 
    end 

    def invalid_bet_when_2_players_left?(amount)
        if two_players_in_bet_round? 
            set_other_player
            set_max_bet_when_2_players_left
            return true if Integer(amount) > max_bet_when_2_players_left
        end 
        false 
    end 

    def must_fold? 
        !able_to_stay && !able_to_call && !able_to_raise
    end 

    def get_player_choice_possibilities
        player_choice_possibilities = ['f']
        player_choice_possibilities << 's' if able_to_stay
        player_choice_possibilities << 'c' if able_to_call
        player_choice_possibilities << 'r' if able_to_raise 
        player_choice_possibilities
    end 

    def get_first_player_choice
        valid_choice = false 

        while !valid_choice
            render 
            show_hand
            puts "#{name}, make a selection." 
            puts "Enter B to bet." 
            puts "Enter F to fold."
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
            puts "Enter S to stay." if able_to_stay 
            puts "Enter C to call." if able_to_call
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
        elsif invalid_bet_when_3_or_4_players_left?(amount)
            puts "Invalid entry. You can't bet more than #{max_of_other_players_chips}, because that's the most chips that another player has. Press return/enter to continue."
            gets 
            return false 
        elsif invalid_bet_when_2_players_left?(amount)
            puts "Invalid entry. You can't bet more than #{max_bet_when_2_players_left}. #{other_player.name} is the only other player left in this round. The number of chips they have is #{other_player.chips} and this round's current bet is #{round_current_bet}. Press return/enter to continue."
            gets 
            return false 
        elsif Integer(amount) > chips
            invalid_amount
            return false 
        end 
  
        true 
    end 

    def get_amount
        while true
            render 
            show_hand
            puts "#{name}, how much do you want to bet? Enter the number of your bet or P to go back."
            user_choice = gets.chomp.downcase 
            if user_choice == 'p'
                return user_choice if user_choice == 'p'
            elsif legal_amount?(user_choice)
                return Integer(user_choice)
            end 
        end 
    end 

    def first_turn_decision
        while true 
            player_choice = get_first_player_choice
            if player_choice == 'b' 
                bet_choice = get_amount
                if bet_choice != 'p' 
                    @bet = bet_choice 
                    @chips -= bet 
                    return bet 
                end 
            else 
                return fold_player
            end 
        end
    end 

    def next_turn_decision_or_fold
        if must_fold? 
            @fold = true 
            render 
            show_hand
            puts "#{name}, you don't have enough chips to see or raise. You have folded."
            puts "Press enter/return to continue."
            gets 
            'f'
        else 
            next_turn_decision 
        end 
    end 

    def next_turn_decision
        while true 
            evaluate_able_to_stay_able_to_call_able_to_raise
            player_choice = get_next_player_choice
            
            if player_choice == 's'
                return 's'
            elsif player_choice == 'c'
                call_amount = round_current_bet - bet 
                @bet += call_amount
                @chips -= call_amount
                return ['c', call_amount]
            elsif player_choice == 'r'
                raise_choice = get_amount 
                if raise_choice != 'p'
                    @bet += raise_choice
                    @chips -= raise_choice 
                    return ['r', bet, raise_choice]
                end 
            elsif player_choice == 'f'
                return fold_player 
            end 
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

    def fold_player 
        @fold = true 
        ['f', 0] 
    end   

    def invalid_entry
        puts "Invalid entry. Press return/enter to continue."
        gets 
    end 

    def invalid_amount 
        puts "Invalid entry. Please enter a number less than or equal to the chips you have. The number of chips you have is #{chips}. Press return/enter to continue."
        gets 
    end 

    def render
        clear 
        show_bet_info
    end 

    def show_bet_info
        puts "POKER"
        puts "Pot - #{pot}" 
        print_chip_count
        puts "\nFolded Players this Round - #{folded_players.join(', ')}" if folded_players
        puts "Player with Highest Bet this Round - #{player_with_highest_bet}" if player_with_highest_bet
        puts "Current Bet this Round - #{round_current_bet}"
        puts "Your Bet this Round - #{bet}"
        puts "Your Chips - #{chips}"
        new_line
    end 

    def print_player_chips(players) 
        players = [] if players == nil 
        players.each { |player| puts "#{player.name} - #{player.chips}" } 
    end 

    def print_chip_count
        puts "\nChips"
        print_player_chips(alive_players)
        print_player_chips(eliminated_players)
    end 

    def show_hand
        print "Hand: "
        hand.hand.each { |card| print "#{card.symbol}  " } 
        new_line
    end 

    def card_in_hand_with_10_card_at_idx_0?(object)
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
        elsif idx == 1 && card_in_hand_with_10_card_at_idx_0?(object)
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
        print "Hand".rjust(15)
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