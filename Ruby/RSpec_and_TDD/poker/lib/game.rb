require_relative 'deck'
require_relative 'player'
require 'byebug'

class Poker 

    attr_reader :deck, :highest_bet, :player_with_highest_bet, :player1, :player2, :player3, :player4, :round_current_bet
    attr_accessor :current_player, :players, :pot 

    def initialize 
        @deck = Deck.new
        @pot = 0 
        @round_current_bet = 0 
        @player1 = Player.new('Jake', deck, pot, round_current_bet)
        @player2 = Player.new('Ann', deck, pot, round_current_bet)
        @player3 = Player.new('Mike', deck, pot, round_current_bet)
        @player4 = Player.new('Mary', deck, pot, round_current_bet)
        @players = [player1, player2, player3, player4]
    end 

    def play 
        until over? 
            set_alive_players
            reset_bet_round_data
            deal_first_cards
            bet_round 

        end 
        result 
    end 

    def reset_bet_round_data
        @round_current_bet = 0 
        @highest_bet = 0 
        @player_with_highest_bet = nil 
        @current_player = first_alive_player
    end 

    def set_alive_players
        players.each { |player| player.alive = false if player.chips == 0 }
    end 

    def first_alive_player
        players.each { |player| return player if player.alive }
    end 

    def alive_players
        live_players = []
        players.each { |player| live_players << player.name if player.alive }
        live_players
    end 

    def deal_first_cards
        players.each { |player| player.deal_cards } 
    end 

    def bet_round 
        first_turn 

        bet_round_over = false 
        while !bet_round_over
            switch_turn





        end 


        #account for if a player is folded and if a player is alive.........player can bet if player.alive && player.fold == false.  

    end 

    #method makes the first bet in a round 
    def first_turn 
        first_choice = current_player.make_first_turn(alive_players)
        if first_choice != 'f'
            @round_current_bet = first_choice
            @pot += first_choice
            set_highest_bet_and_player(first_choice)
        end 
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




