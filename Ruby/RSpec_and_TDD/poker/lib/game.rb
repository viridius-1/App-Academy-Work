require_relative 'deck'
require_relative 'player'
require 'byebug'

class Poker 

    attr_reader :deck, :highest_bet, :player_with_highest_bet
    attr_accessor :current_player, :players, :player1, :player2, :player3, :player4, :pot, :round_current_bet

    def initialize 
        @deck = Deck.new
        @player1 = Player.new('Jake', deck)
        @player2 = Player.new('Ann', deck)
        @player3 = Player.new('Mike', deck)
        @player4 = Player.new('Mary', deck)
        @players = [player1, player2, player3, player4]
    end 

    def play 
        #until over? 
            set_alive_players
            reset_pot 
            reset_bet_round_data
            deal_first_cards
            bet_round 
            exchange_cards
            bet_round

            #set_bet_round1_finished_to_false at end of round for each player 
        #end 
        #result 
    end 

    def deal_first_cards
        players.each { |player| player.deal_cards } 
    end 

    def exchange_cards
        players.each { |player| player.exchange_cards } 
    end 

    def reset_pot
        @pot = 0 
    end 

    def reset_bet_round_data
        @round_current_bet = 0 
        @highest_bet = 0 
        @player_with_highest_bet = nil 
        @current_player = first_alive_player
        reset_player_bet_round_data
    end 

    def reset_player_bet_round_data
        players.each { |player| player.reset_bet_data }
    end 

    def set_alive_players
        players.each { |player| player.alive = false if player.chips == 0 }
    end 

    def toggle_bet_round1_finished_and_already_bet
        players.each { |player| player.toggle_bet_round1_finished_and_already_bet } 
    end 

    def first_alive_player
        players.each { |player| return player if player.alive }
    end 

    def alive_players
        live_players = [] 
        players.each { |player| live_players << player.name if player.alive }
        live_players
    end 

    def folded_players 
        folded = []
        players.each { |player| folded << player.name if player.fold }
        folded 
    end 

    def bet_round 
        first_turn 

        bet_round_over = false 
        while !bet_round_over
            if three_players_folded? 
                bet_round_over = true 
            else 
                update_pot_and_round_current_bet_for_players
                switch_turn
                if current_player_is_player_with_highest_bet? 
                    bet_round_over = true 
                else 
                    next_turn
                end 
            end 
        end  

        toggle_bet_round1_finished_and_already_bet
    end 

    #method makes the first bet in a round 
    def first_turn 
        if !current_player.bet_round1_finished
            first_choice = current_player.make_first_turn(alive_players)
        else 
            return next_turn
        end 

        if first_choice != 'f'
            set_round_current_bet(first_choice)
            increase_pot(first_choice)
            set_highest_bet_and_player(first_choice)
        end 
    end 

    def next_turn
        choice_of_next_player = make_next_turn  
        if choice_of_next_player_is_raise?(choice_of_next_player[0]) 
            increase_pot(choice_of_next_player[2]) 
            set_round_current_bet(choice_of_next_player[1])
            set_highest_bet_and_player(choice_of_next_player[1]) if bet_is_higher_than_highest_bet?(choice_of_next_player[1]) 
        else   
            increase_pot(choice_of_next_player[1]) 
        end 
    end 

    def make_next_turn
        current_player.make_next_turn(alive_players, folded_players, player_with_highest_bet.name)
    end 

    def update_pot_and_round_current_bet_for_players       
        players.each do |player| 
            player.pot = pot 
            player.round_current_bet = round_current_bet
        end 
    end 

    def current_player_is_player_with_highest_bet? 
        current_player == player_with_highest_bet
    end 

    def choice_of_next_player_is_raise?(choice)
        choice == 'r'
    end 

    def bet_is_higher_than_highest_bet?(bet)
        bet > highest_bet
    end 

    def increase_pot(amount) 
        @pot += amount 
    end 

    def set_round_current_bet(amount)
        @round_current_bet = amount 
    end 

    def set_highest_bet_and_player(bet)
        @highest_bet = bet 
        @player_with_highest_bet = current_player
    end 

    def get_current_player_idx 
        players.each_with_index { |player, idx| return idx if player == current_player }
    end 

    def player_allowed_to_take_turn?(player) 
        player.alive && player.fold == false 
    end 

    def switch_turn 
        current_player_idx = get_current_player_idx

        switch_turn_complete = false 
        while !switch_turn_complete
            current_player_idx += 1 
            current_player_idx = 0 if current_player_idx == players.length 
            player_at_next_turn = players[current_player_idx]
            if player_allowed_to_take_turn?(player_at_next_turn)
                @current_player = player_at_next_turn
                switch_turn_complete = true 
            end 
        end 
    end 

    def three_players_folded?
        players_folded = 0 
        players.each { |player| players_folded += 1 if player.fold }
        players_folded == 3 
    end 

    def over? 
        players_with_no_chips = 0
        players.each { |player| players_with_no_chips += 1 if player.chips == 0 }
        players_with_no_chips == 3 
    end 

    def winner 
        players.each { |player| return player.name if player.chips > 0 }
    end 

    def result 
        puts "#{winner} wins! Game over."
    end 

end 




# def award_pot(player)
#     player.chips += pot 
#     pot -= 8 
# end 



#the method for award_pot should probably be able to take in 2 parameters. B/c you can have 1 winner....but you can also have a case where the pot needs to be split. So maybe this method takes in an array of players.

# NEED TO ACCOUNT FOR SITUATIONS LIKE THIS....THERE WILL NEED TO BE A SECOND TEST....IMAGINE TWO 5S VS TWO 8S....NEED TO APPLY THIS ACROSS ALL HANDS
#  it 'ranks a higher one pair hand over a lower one pair hand' do 
#     allow(higher_one_pair_hand).to receive(:calculate).and return(8)
#     allow(lower_one_pair_hand).to receive(:calculate).and return(8)
#     expect(game.compare_hands).to eq(higher_one_pair_hand)
# end 



#the below code was in bet_round.....
 # if round_current_bet == player_with_highest_bet.bet 
#     bet_round_over = true 
# else 
#     choice_of_player_with_highest_bet = next_turn 
#     if choice_of_player_with_highest_bet[0] == 's'
#         @pot += choice_of_player_with_highest_bet[1]
#         bet_round_over = true 
#     elsif choice_of_player_with_highest_bet[0] == 'r'
#         @pot += choice_of_player_with_highest_bet[1]
#         set_highest_bet_and_player(choice_of_player_with_highest_bet) if choice_of_player_with_highest_bet[1] > highest_bet
#     elsif choice_of_player_with_highest_bet[0] == 'f'
#         bet_round_over = true 
#     end 
# end 


###method before modifying it...
#   def bet_round 
#         first_turn 

#         bet_round_over = false 
#         while !bet_round_over
#             if three_players_folded? 
#                 bet_round_over = true 
#             else 
#                 update_pot_and_round_current_bet_for_players
#                 switch_turn
#                 if current_player_is_player_with_highest_bet? 
#                     bet_round_over = true 
#                 else 
#                     choice_of_next_player = next_turn  
#                     increase_pot(choice_of_next_player[1]) 
#                     if choice_of_next_player_is_raise?(choice_of_next_player[0]) 
#                         set_round_current_bet(choice_of_next_player[1])
#                         set_highest_bet_and_player(choice_of_next_player[1]) if bet_is_higher_than_highest_bet?(choice_of_next_player[1]) 
#                     end 
#                 end 
#             end 
#         end  
#     end 