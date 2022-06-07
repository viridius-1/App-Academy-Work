require_relative 'deck'
require_relative 'player'

class Poker 

    attr_reader :deck, :hand_score, :high_score, :highest_bet, :player_with_highest_bet, :suit_rank, :winner_of_tie
    attr_accessor :current_player, :players, :player1, :player2, :player3, :player4, :player_names, :pot, :round_current_bet, :round_winner, :winning_hand_score, :winning_players_of_round

    def initialize 
        @deck = Deck.new
        @suit_rank = { "♠" => 1, "♡" => 2, "♢" => 3, "♣" => 4 }
        introduction 
        choose_players
        play
    end 

    def play 
        until over? 
            set_alive_players
            reset_deck 
            reset_pot 
            reset_already_bet
            reset_bet_round_data
            deal_first_cards
            bet_round 
            update_bet_round_data_for_each_player 
            exchange_cards
            bet_round
            winners_of_round
            award_pot 
        end 
        result 
    end 
 
    private 

    def introduction
        puts "Welcome to Poker!"
        puts "This is a five-card draw poker game."
        puts "Read about five-card draw at https://en.wikipedia.org/wiki/Five-card_draw"
        puts "Read about the types of poker hands at https://en.wikipedia.org/wiki/List_of_poker_hands"
        puts "You are allowed to exchange 3 cards per hand."
        puts "Press enter/return to continue."
        gets 
    end 

    def choose_players_prompt 
        clear 
        puts "Enter the number of players."
        puts "2 - Two Players"
        puts "3 - Three Players"
        puts "4 - Four Players"
    end 

    def get_player_names(amount)
        player_names = []

        clear 
        Integer(amount).times do |i| 
            puts "Player #{i + 1}, enter your name:"
            user_name = gets.chomp 
            player_names << user_name
            puts "\n"
        end 

        player_names
    end 

    def choose_players
        valid_player_ct = false 

        while !valid_player_ct
            choose_players_prompt
            user_choice_ct = gets.chomp 
            if ['2', '3', '4'].include?(user_choice_ct)
                valid_player_ct = true 
            else 
                puts "Invalid entry. Please enter 2, 3, or 4. Press enter/return to continue."
                gets 
            end 
        end 

        create_players(Integer(user_choice_ct)) 
    end 

    def create_players(amount)
        @player_names = get_player_names(amount)
        if amount == 2 
            create_two_players
        elsif amount == 3 
            create_three_players
        else 
            create_four_players
        end 
    end 

    def create_two_players
        @player1 = Player.new(player_names[0], deck)
        @player2 = Player.new(player_names[1], deck)
        @players = [player1, player2]
    end 

    def create_three_players
        create_two_players
        @player3 = Player.new(player_names[2], deck) 
        @players = [player1, player2, player3]
    end 

    def create_four_players
        create_three_players
        @player4 = Player.new(player_names[3], deck) 
        @players = [player1, player2, player3, player4] 
    end 

    def deal_first_cards
        players.each { |player| player.deal_cards if player.alive } 
    end 

    def exchange_cards
        players.each { |player| player.exchange_cards if player_allowed_to_take_turn?(player) } 
    end 

    def reset_deck 
        deck.fill_deck
        deck.shuffle_cards
    end 

    def reset_pot
        @pot = 0 
    end 

    def reset_current_player 
        @current_player = first_alive_player
    end 

    def reset_already_bet
        players.each { |player| player.already_bet = false }
    end 

    def reset_highest_bet_and_player_with_highest_bet
        @highest_bet = 0 
        @player_with_highest_bet = nil 
    end 

    def reset_bet_round_data
        @round_current_bet = 0 
        reset_highest_bet_and_player_with_highest_bet
        reset_current_player
        reset_player_bet_round_data
    end 

    def reset_player_bet_round_data
        players.each { |player| player.reset_bet_data }
    end 

    def reset_winning_players_of_round 
        @winning_players_of_round = []
    end 

    def reset_winner_of_tie_and_high_score 
        @winner_of_tie = nil 
        @high_score = nil 
    end 

    def set_winner_of_tie_and_high_score(player, score)
        @winner_of_tie = player 
        @high_score = score 
    end 

    def set_alive_players
        players.each { |player| player.alive = false if player.chips == 0 }
    end 

    def set_round_current_bet(amount)
        @round_current_bet = amount 
    end 

    def set_highest_bet_and_player_with_highest_bet(bet, player)
        @highest_bet = bet 
        @player_with_highest_bet = player
    end 

    def update_player_with_highest_bet
        if player_with_highest_bet 
            player_with_highest_bet.name
        else 
            nil 
        end 
    end 

    def update_pot_and_round_current_bet_for_players       
        players.each do |player| 
            player.pot = pot 
            player.round_current_bet = round_current_bet
        end 
    end 

    def update_bet_round_data_for_each_player 
        players.each do |player| 
            player.folded_players = folded_players 
            player.player_with_highest_bet = update_player_with_highest_bet
            player.round_current_bet = round_current_bet
        end 
    end 

    def increase_pot(amount) 
        @pot += amount 
    end 

    def get_current_player_idx 
        players.each_with_index { |player, idx| return idx if player == current_player }
    end 

    def player_allowed_to_take_turn?(player) 
        player.alive && player.fold == false 
    end 

    def current_player_is_player_with_highest_bet? 
        current_player == player_with_highest_bet
    end 

    def choice_is_call?(choice)
        choice == 'c'
    end 

    def choice_is_raise?(choice)
        choice == 'r'
    end 

    def choice_is_fold?(choice)
        choice == 'f'
    end     

    def bet_is_higher_than_highest_bet?(bet)
        bet > highest_bet
    end 

    def toggle_bet_round1_finished_and_already_bet
        players.each { |player| player.toggle_bet_round1_finished_and_already_bet } 
    end 

    def first_alive_player
        players.each { |player| return player if player.alive }
    end 

    def alive_players
        live_players = [] 
        players.each { |player| live_players << player if player.alive }
        live_players
    end 

    def eliminated_players 
        eliminated = []
        players.each { |player| eliminated << player unless player.alive}
        eliminated
    end 

    def folded_players 
        folded = []
        players.each { |player| folded << player.name if player.fold }
        folded 
    end 

    def name_of_player_with_highest_bet
        if player_with_highest_bet
            player_with_highest_bet.name
        else 
            ''
        end 
    end 

    def bet_round 
        first_turn 

        bet_round_over = false 
        while !bet_round_over
            if other_players_folded? 
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
            first_choice = current_player.make_first_turn(alive_players, eliminated_players)
        else 
            if !other_players_folded?
                return next_turn 
            else 
                return 
            end 
        end 
       
        unless choice_is_fold?(first_choice[0])    
            set_round_current_bet(first_choice)
            increase_pot(first_choice)
            set_highest_bet_and_player_with_highest_bet(first_choice, current_player)
        end 
    end 

    def next_turn
        choice_of_next_player = make_next_turn  
        if choice_is_raise?(choice_of_next_player[0]) 
            increase_pot(choice_of_next_player[2]) 
            set_round_current_bet(choice_of_next_player[1])
            set_highest_bet_and_player_with_highest_bet(choice_of_next_player[1], current_player) if bet_is_higher_than_highest_bet?(choice_of_next_player[1]) 
        elsif choice_is_fold?(choice_of_next_player[0]) && current_player_is_player_with_highest_bet?
            reset_highest_bet_and_player_with_highest_bet
        elsif choice_is_call?(choice_of_next_player[0])    
            increase_pot(choice_of_next_player[1]) 
        end 
    end 

    def make_next_turn
        current_player.make_next_turn(alive_players, eliminated_players, folded_players, name_of_player_with_highest_bet)
    end 

    def reset_winning_players_of_round_if_hand_score_is_less_than_winning_hand_score 
        if winning_hand_score
            reset_winning_players_of_round if hand_score < winning_hand_score 
        end 
    end 

    def winning_player_evaluation(player)
        @hand_score = player.calculate_hand
        if winning_hand_score == nil || hand_score <= winning_hand_score
            reset_winning_players_of_round_if_hand_score_is_less_than_winning_hand_score
            @winning_players_of_round << player 
            @winning_hand_score = hand_score
        end 
     end 

    def winners_of_round
        reset_winning_players_of_round 
        @winning_hand_score = nil 
        players.each { |player| winning_player_evaluation(player) if player_allowed_to_take_turn?(player) }  
    end 

    def award_pot 
        if winning_players_of_round.length == 1 
            award_pot_to_winner(winning_players_of_round[0])
        else 
            evaluate_tie
        end 
    end 

    def award_pot_to_winner(winner_of_round)
        winner_of_round.chips += pot 
        print_round_results 
        puts "#{winner_of_round.name} wins the round. #{winner_of_round.name} has received #{pot} chips. Press enter/return to continue."
        gets 
        @round_winner = winner_of_round 
    end 

    #method looks at what type of hand the tie is. Then chooses appropriate method to assess the winner of the round. 
    def evaluate_tie_for_hand(hand_type)
        case hand_type
        when 1 
            evaluate_winner_by_suit #for royal flush 
        when 2
            evaluate_four_of_a_kind_tie 
        when 3
            evaluate_three_of_a_kind_tie
        when 4
            evaluate_high_card_tie #for flush 
        when 5
            evaluate_straight_tie
        when 6
            evaluate_three_of_a_kind_tie
        when 7
            evaluate_two_pair_tie
        when 8
            evaluate_one_pair_tie
        when 9
            evaluate_high_card_tie
        end 
    end 

    def evaluate_tie 
        reset_winner_of_tie_and_high_score
        hand_type = winning_players_of_round[0].calculate_hand 
        evaluate_tie_for_hand(hand_type)       
    end 

    def winner_unassigned 
        winner_of_tie == nil
    end 

    def get_arr_of_pairs(values)
        pairs = []
        
        0.upto(values.length - 2) do |idx1| 
            (idx1 + 1).upto(values.length - 1) do |idx2| 
                if values[idx1] == values[idx2] 
                    pairs << values[idx1]
                    pairs << values[idx2]
                end 
            end 
        end 

        pairs.sort.reverse
    end 

    def get_fifth_card(values, arr_of_two_pairs)
        values.each { |value| return value unless arr_of_two_pairs.include?(value) } 
    end 

    def get_arr_of_three_other_cards(values, pair) 
        three_other_values = []
        values.each { |value| three_other_values << value unless pair.include?(value) }
        three_other_values.sort.reverse 
    end 

    def sort_hand_values_of_winning_players_of_round
        winning_players_of_round.each { |player| player.hand_values.sort!.reverse! }
    end 

    def sort_two_pair_hand_values_of_winning_players_of_round
        winning_players_of_round.each { |player| player.hand_values = sort_values_for_two_pairs(player.hand_values) } 
    end 

    def sort_one_pair_hand_values_of_winning_players_of_round
        winning_players_of_round.each { |player| player.hand_values = sort_values_for_one_pair(player.hand_values) } 
    end 

    def sort_values_for_two_pairs(values)
        arr_of_two_pairs = get_arr_of_pairs(values) 
        fifth_card = get_fifth_card(values, arr_of_two_pairs)
        arr_of_two_pairs << fifth_card
    end 

    def sort_values_for_one_pair(values)
        arr_of_one_pair = get_arr_of_pairs(values) 
        arr_of_three_other_cards = get_arr_of_three_other_cards(values, arr_of_one_pair) 
        arr_of_three_other_cards.each { |value| arr_of_one_pair << value }
        arr_of_one_pair
    end 

    def evaluate_winner_by_suit
        winning_players_of_round.each do |player| 
            score = suit_rank[player.suit_of_first_card_in_hand]
            set_winner_of_tie_and_high_score(player, score) if winner_unassigned || score < high_score
        end 
        award_pot_to_winner(winner_of_tie)
    end 

    def evaluate_winner_by_suit_of_high_pair
        seen_cards = []

        2.times do |idx| 
            winning_players_of_round.each do |player| 
                value = player.hand_values[idx]
                card = find_card_of_value_in_player_hand(seen_cards, value, player)
                seen_cards << card 
                return award_pot_to_winner(player) if card.suit == "♠"
            end 
        end 
    end 

    def find_card_of_value_in_player_hand(seen_cards, value, player)
        player.player_hand.each { |card| return card if card.value == value && !seen_cards.include?(card) } 
    end 

    def evaluate_four_of_a_kind_tie
        winning_players_of_round.each do |player| 
            score = player.value_of_four_of_a_kind
            set_winner_of_tie_and_high_score(player, score) if winner_unassigned || score > high_score 
        end 
        award_pot_to_winner(winner_of_tie)
    end 

    def evaluate_three_of_a_kind_tie 
        winning_players_of_round.each do |player| 
            score = player.value_of_three_of_a_kind
            set_winner_of_tie_and_high_score(player, score) if winner_unassigned || score > high_score 
        end 
        award_pot_to_winner(winner_of_tie)
    end 

    def evaluate_high_card_tie 
        sort_hand_values_of_winning_players_of_round

        if high_card_winner?(5)
            true 
        else 
            evaluate_winner_by_suit
        end 
    end 

    def evaluate_straight_tie
        sort_hand_values_of_winning_players_of_round

        if high_card_winner?(1)
            true 
        else 
            evaluate_winner_by_suit
        end
    end 

    def evaluate_two_pair_tie
        sort_two_pair_hand_values_of_winning_players_of_round
        pair_winner
    end 

    def evaluate_one_pair_tie
        sort_one_pair_hand_values_of_winning_players_of_round
        pair_winner
    end 

    def pair_winner 
        if high_card_winner?(5)
            true 
        else 
            evaluate_winner_by_suit_of_high_pair
        end 
    end 

    #method identifies if there is a winner among the winning_players_of_round based on whether they have the high card
    def high_card_winner?(iterations)
        iterations.times do |idx|  
            card_values_of_each_player = {}
            winning_players_of_round.each { |player| card_values_of_each_player[player] = player.hand_values[idx] } 
            high_card_result = get_high_card_result(card_values_of_each_player)
            if high_card_result 
                award_pot_to_winner(high_card_result)
                return true 
            end 
        end 

        false 
    end 

    #method returns a player if that player has a higher card than all other player cards. otherwise returns false.  
    def get_high_card_result(card_values_of_each_player)
        card_values_of_each_player.each do |player1, value1| 
            values_of_other_cards = []
            card_values_of_each_player.each { |player2, value2| values_of_other_cards << value2 if player1 != player2 }  
            return player1 if values_of_other_cards.all? { |value| value1 > value }
        end 
        
        false 
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

    def other_players_folded?
        players_folded = 0 
        players.each { |player| players_folded += 1 if player.fold }

        if players.length == 4 
            players_folded == 3 
        elsif players.length == 3
            players_folded == 2 
        else    
            players_folded == 1 
        end 
    end 

    def over? 
        players_with_no_chips = 0
        players.each { |player| players_with_no_chips += 1 if player.chips == 0 }
        players_with_no_chips == players.length - 1 
    end 

    def winner 
        players.each { |player| return player.name if player.chips > 0 }
    end 

    def result 
        clear 
        puts "POKER\n\n"
        print_chip_count 
        puts "\n#{winner} wins! Game over."
    end 

    def print_chip_count
        puts "Chips"
        players.each { |player| puts "#{player.name} - #{player.chips}" } 
    end 

    def print_players_status 
        players.each do |player| 
            print "#{player.name} - "
            if player.no_chips?
                print "Eliminated"
            elsif player.fold
                print "Folded"
            else  
                player.player_hand.each { |card| print "#{card.symbol} " } 
            end 
            new_line
        end 
        new_line
    end 

    def print_round_results 
        clear 
        puts "POKER"
        print "Pot was #{pot}"
        2.times { new_line } 
        print_chip_count
        new_line 
        print_players_status 
    end 

    def new_line
        puts "\n"
    end 

    def clear 
        system("clear")
    end 

end 


if __FILE__ == $PROGRAM_NAME
 	g = Poker.new
    g.play 
end



