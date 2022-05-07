require 'rspec'
require 'game'

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

    context 'when switching turns' do 
        describe '#switch_turn' do  
            it 'switches turns' do 
                game.current_player = player1
                game.switch_turn 
                expect(game.current_player).to eq(player2)
            end 

            it "doesn't switch a turn to a player that has folded" do 
                allow(player3).to receive(:fold).and_return(true)
                game.switch_turn
                expect(game.current_player).to eq(player4)
            end 
        end 
    end 
     
    context 'when comparing hands' do 
        describe '#compare_hands' do 
            it 'ranks a straight flush above four of a kind' do 
                allow(straight_flush).to receive(:calculate).and_return(1)
                allow(four_of_a_kind).to receive(:calculate).and_return(2)
                expect(game.compare_hands(straight_flush, four_of_a_kind)).to eq(straight_flush)
            end 

            it 'ranks three of a kind below a straight' do 
                allow(three_of_a_kind).to receive(:calculate).and_return(6)
                allow(straight).to receive(:calculate).and_return(5)
                expect(game.compare_hands(three_of_a_kind, straight)).to eq(straight)
            end 

            # it 'ranks a higher one pair hand (two 8s) over a lower one pair hand (two 5s)' do 
            #     allow(two_eights_one_pair_hand).to receive(:calculate).and return(8)
            #     allow(two_fives_one_pair_hand).to receive(:calculate).and return(8)
            #     expect(game.compare_hands(two_eights_one_pair_hand, two_fives_one_pair_hand)).to eq(two_eights_one_pair_hand)
            # end 
        end 
    end 

    describe '#pot' do 
        it 'tracks the amount in the pot' do 
            game.pot = 4
            expect(game.pot).to eq(4)
        end 
    end 

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
#a player has chips 
#context - when game starts 
    #a player can have a hand 
    #player has 5 cards when game starts 
#a player can bet 
#a player can receive chips 
#a player can fold, see the current bet, or raise 
#a player can discard 3 cards, 2 cards, 1 card, or no cards 
#a player can be dealt new cards to replace their old cards
#player is out of game if they fold 
#a player's hand can be revealed 

#GAME
#keeps track of whose turn it is 
#can switch player turns 
#player can no longer take turns if they fold
#can compare hands to identify which hand is better 
#tracks the amount in the pot 
#gives the winner the pot 
#if there is a draw....
    #it splits the pot if it can be split evenly 
    #if it cant be split evenly, the odd money piece goes by suit rank...from high to low the rank is.....ace, hearts, diamonds, clubs


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