require 'rspec'
require 'game'
require 'byebug'

describe Poker do 
    subject(:game) { Poker.new }

    let(:player1) { double('player1') }
    let(:player2) { double('player2') }
    let(:player3) { double('player3') }
    let(:player4) { double('player4') }

    let(:straight_flush) { double('straight_flush') }
    let(:four_of_a_kind) { double('four_of_a_kind') }
    let(:three_of_a_kind) { double('three_of_a_kind') }
    let(:straight) { double('straight') }
    let(:two_eights_one_pair_hand) { double('two_eights_one_pair_hand') }
    let(:two_fives_one_pair_hand) { double('two_fives_one_pair_hand') }

    before(:each) do 
        game.players = [player1, player2, player3, player4]
        game.current_player = player1 
        game.pot = 0 
        game.round_current_bet = 0 
    end 

    describe '#deal_first_cards' do 
        it 'deals cards to every player' do 
            allow(player1).to receive(:deal_cards)
            allow(player2).to receive(:deal_cards)
            allow(player3).to receive(:deal_cards)
            allow(player4).to receive(:deal_cards)
            game.deal_first_cards
        end 
    end 

    describe '#set_highest_bet_and_player' do 
        it 'sets the highest bet and player with the highest bet for a round' do 
            game.current_player = player1
            game.set_highest_bet_and_player(2)
            expect(game.highest_bet).to eq(2)
            expect(game.player_with_highest_bet).to eq(player1)
        end 
    end 

    describe '#pot' do 
        it 'tracks the amount in the pot' do 
            game.pot = 4
            expect(game.pot).to eq(4)
        end 
    end 

    #maybe a test for increase_pot

    describe '#award_pot' do 
        it 'awards the pot to the showdown winner' do 
            allow(player1).to receive(:chips).and_return(game.pot)
            expect { game.award_pot(player1) }.to_not raise_error 
        end 

        it 'resets the pot to 0 after awarding the pot' do 
            game.award_pot
            expect(game.pot).to eq(0)
        end     

        it 'splits an even pot when there is a draw' do 
            game.pot = 8 
            allow(player1).to receive(:chips).and_return(game.pot / 2)
            allow(player2).to receive(:chips).and_return(game.pot / 2)
            expect { game.award_pot(player1, player2) }.to_not raise_error 
        end 

        #make another it block?........if pot cant be split evenly, the odd money piece goes by suit rank...from high to low the rank is.....ace, hearts, diamonds, clubs
    end 

    describe '#three_players_folded?' do 
        it 'returns true when 3 players have folded' do 
            allow(player1).to receive(:fold).and_return(false)
            allow(player2).to receive(:fold).and_return(true)
            allow(player3).to receive(:fold).and_return(true)
            allow(player4).to receive(:fold).and_return(true)
            expect(game.three_players_folded?).to be(true)
        end 

        it 'returns false when 3 players have not folded' do 
            allow(player1).to receive(:fold).and_return(false)
            allow(player2).to receive(:fold).and_return(false)
            allow(player3).to receive(:fold).and_return(true)
            allow(player4).to receive(:fold).and_return(true)
            expect(game.three_players_folded?).to be(false)
        end 
    end 

    context 'when a bet round is running' do
        before(:each) do 
            allow(player1).to receive(:alive).and_return(true)
            allow(player1).to receive(:name).and_return('Jake')
            allow(player2).to receive(:alive).and_return(true)
            allow(player2).to receive(:name).and_return('Ann')
            allow(player3).to receive(:alive).and_return(true)
            allow(player3).to receive(:name).and_return('Mike')
            allow(player4).to receive(:alive).and_return(true)
            allow(player4).to receive(:name).and_return('Mary')

            allow(player1).to receive(:fold).and_return(false)
            allow(player2).to receive(:fold).and_return(false)
            allow(player3).to receive(:fold).and_return(false)
            allow(player4).to receive(:fold).and_return(false)

            alive_players = ['Jake', 'Ann', 'Mike', 'Mary'] 

            expect(player1).to receive(:make_first_turn).with(alive_players).and_return(1)
            game.first_turn 
        end 

        describe '#first_turn' do
            it "sets the round's current bet when the player bets" do
                expect(game.round_current_bet).to eq(1)
            end 

            it "increases the pot by the player's bet" do 
                expect(game.pot).to eq(1)
            end 

            it 'sets the highest bet' do 
                expect(game.highest_bet).to eq(1)
            end 

            it 'sets the player with the highest bet' do 
                expect(game.player_with_highest_bet).to eq(player1)
            end 
        end 

        describe '#next_turn' do 
            before(:each) do 
                alive_players = ['Jake', 'Ann', 'Mike', 'Mary'] 
                folded_players = []
                game.pot = 0 
                expect(player1).to receive(:make_next_turn).with(alive_players, folded_players, 'Jake').and_return(['s', 3])
                game.next_turn
            end 

            it 'increases the pot when a player sees' do 
                expect(game.pot).to eq(3)
            end 

            it "sets the round's current bet when a player raises" do 
                alive_players = ['Jake', 'Ann', 'Mike', 'Mary'] 
                folded_players = []
                expect(player1).to receive(:make_next_turn).with(alive_players, folded_players, 'Jake').and_return(['r', 4])
                game.next_turn
                expect(game.round_current_bet).to eq(4)
            end 

            it 'sets the highest bet when a player raises' do 
                alive_players = ['Jake', 'Ann', 'Mike', 'Mary'] 
                folded_players = []
                expect(player1).to receive(:make_next_turn).with(alive_players, folded_players, 'Jake').and_return(['r', 4])
                game.next_turn
                expect(game.highest_bet).to eq(4)
            end 

            it 'sets the player with the highest bet when a player raises' do 
                alive_players = ['Jake', 'Ann', 'Mike', 'Mary'] 
                folded_players = []
                expect(player1).to receive(:make_next_turn).with(alive_players, folded_players, 'Jake').and_return(['r', 4])
                game.next_turn
                expect(game.player_with_highest_bet).to eq(player1)
            end 
        end 
    end 

    context 'when switching turns' do 
        describe '#switch_turn' do  
            before(:each) do 
                game.current_player = player1
                allow(player2).to receive(:alive).and_return(true) 
            end 

            it 'switches turns' do 
                allow(player2).to receive(:fold).and_return(false)
                game.switch_turn 
                expect(game.current_player).to eq(player2)
            end 

            it "doesn't switch a turn to a player that has folded" do 
                allow(player2).to receive(:fold).and_return(true)
                allow(player3).to receive(:alive).and_return(true) 
                allow(player3).to receive(:fold).and_return(false)
                game.switch_turn
                expect(game.current_player).to eq(player3)
            end 
        end 
    end 

    # context 'when comparing hands' do 
    #     describe '#compare_hands' do 
    #         it 'ranks a straight flush above four of a kind' do 
    #             allow(straight_flush).to receive(:calculate).and_return(1)
    #             allow(four_of_a_kind).to receive(:calculate).and_return(2)
    #             expect(game.compare_hands(straight_flush, four_of_a_kind)).to eq(straight_flush)
    #         end 

    #         it 'ranks three of a kind below a straight' do 
    #             allow(three_of_a_kind).to receive(:calculate).and_return(6)
    #             allow(straight).to receive(:calculate).and_return(5)
    #             expect(game.compare_hands(three_of_a_kind, straight)).to eq(straight)
    #         end 

    #         it 'ranks a higher one pair hand (two 8s) over a lower one pair hand (two 5s)' do 
    #             allow(two_eights_one_pair_hand).to receive(:calculate).and return(8)
    #             allow(two_fives_one_pair_hand).to receive(:calculate).and return(8)
    #             expect(game.compare_hands(two_eights_one_pair_hand, two_fives_one_pair_hand)).to eq(two_eights_one_pair_hand)
    #         end 
    #     end 
    # end

    context 'when game is over' do 
        describe '#over?' do 
            before(:each) do 
                allow(player1).to receive(:chips).and_return(40)
                allow(player2).to receive(:chips).and_return(0)
                allow(player3).to receive(:chips).and_return(0)
                allow(player4).to receive(:chips).and_return(0)

                allow(player1).to receive(:name).and_return('Jake')
                allow(player2).to receive(:name).and_return('Ann')
                allow(player3).to receive(:name).and_return('Mike')
                allow(player4).to receive(:name).and_return('Mary')
            end 

            it 'returns true if the game is over' do 
                expect(game.over?).to be(true)
            end 

            it 'returns the correct winner' do 
                expect(game.winner).to eq('Jake')
            end 
        end 
    end 

 

end 



#CARD 
#has symbol
#has value 

#DECK
#has array of all cards
#can deal a specified amount of cards 
#does not retain cards after dealing them 
#can shuffle cards 

#HAND 
#can calculate a hand - pair, full house, etc 

#PLAYER 
#pending 
#a player can bet 
#a player can raise 
#player is out of game if they fold 
#a player's hand can be revealed 
#done 
#a player has chips 
#context - when game starts 
    #a player can have a hand 
    #player has 5 cards when game starts 
#a player can receive chips 
#a player can fold, see the current bet
#a player can discard 3 cards, 2 cards, 1 card, or no cards 
#a player can be dealt new cards to replace their old cards


#GAME
#test all the methods Im setting up 
#keeps track of whose turn it is 
#can switch player turns 
#player can no longer take turns if they fold
#can compare hands to identify which hand is better 
#tracks the amount in the pot 
#gives the winner the pot 
#if there is a draw....
    #it splits the pot if it can be split evenly 
    #if it cant be split evenly, the odd money piece goes by suit rank...from high to low the rank is.....ace, hearts, diamonds, clubs
#game runs until only 1 player has chips 

=begin 
p "\u2660" #spades 
p "\u2663" #clubs 
p "\u2661" #hearts 
p "\u2662" #diamonds

A - 14  
K - 13  
Q - 12 
J - 11 
10 
9 
8 
7 
6 
5 
4 
3 
2 
=end 