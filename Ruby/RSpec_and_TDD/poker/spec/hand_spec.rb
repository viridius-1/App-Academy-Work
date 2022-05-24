require 'rspec'
require 'hand'

describe Hand do 
    let(:deck) { double('deck') }
    subject(:test_hand) { Hand.new(deck) }  
    before(:each) { allow(deck).to receive(:deal).with(5) } 

    describe '#high_card_rank' do 
        it 'returns the rank of the highest card in a hand' do 
            test_hand.hand = [
                ace_of_diamonds = Card.new("A", "♢", 14), 
                king_of_diamonds = Card.new("K", "♢", 13),
                queen_of_diamonds = Card.new("Q", "♢", 12),
                jack_of_diamonds = Card.new("J", "♢", 11),
                five_of_diamonds = Card.new("5", "♢", 5)
            ]
            expect(test_hand.rank(test_hand.hand)).to eq(14)
        end 
    end     

    describe '#all_cards_have_same_suit?' do 
        it 'returns true when all cards have the same suit' do 
            test_hand.suits = ["♢", "♢", "♢", "♢", "♢"]
            expect(test_hand.all_cards_have_same_suit?).to be(true)
        end 

        it "returns false when all cards don't have the same suit" do 
            test_hand.suits = ["♢", "♢", "♢", "♢", "♣"]
            expect(test_hand.all_cards_have_same_suit?).to be(false)
        end 
    end 

    describe '#all_cards_have_values_that_differ_by_1?' do 
        it 'returns true when all cards have values that differ by 1' do 
            test_hand.values = [14, 13, 12, 11, 10]
            expect(test_hand.all_cards_have_values_that_differ_by_1?).to be(true)
        end 

        it "returns false when all cards don't have values that differ by 1" do 
            test_hand.values = [14, 13, 12, 11, 8]
            expect(test_hand.all_cards_have_values_that_differ_by_1?).to be(false)
        end 
    end 

    context "when evaluating a hand" do 
        describe '#straight_flush?' do 
            it 'returns true when the hand is a straight flush' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♢", 11),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_suits
                test_hand.get_values
                expect(test_hand.straight_flush?).to be(true)
            end 

            it 'returns false when the hand is not a straight flush' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♢", 11),
                    Card.new("5", "♢", 5)
                ]
                test_hand.get_suits
                test_hand.get_values
                expect(test_hand.straight_flush?).to be(false)
            end 
        end 

        describe '#four_of_a_kind?' do 
            it 'returns true when the hand is four of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("10", "♠", 10),
                    Card.new("Q", "♢", 12),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.four_of_a_kind?).to be(true)
            end 

            it 'returns false when the hand is not four of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("Q", "♢", 12),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.four_of_a_kind?).to be(false)
            end 
        end 

        describe '#full_house?' do 
            it 'returns true when the hand is a full house' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("9", "♢", 9),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.full_house?).to be(true)
            end 

            it 'returns false when the hand is not a full house' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.full_house?).to be(false)
            end 
        end 

        describe '#flush?' do 
            it 'returns true when the hand is a flush' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♣", 9),
                    Card.new("2", "♣", 2),
                    Card.new("Q", "♣", 12),
                    Card.new("J", "♣", 11)
                ]
                test_hand.get_suits
                expect(test_hand.flush?).to be(true)
            end 

            it 'returns false when the hand is not a flush' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♢", 9),
                    Card.new("2", "♣", 2),
                    Card.new("Q", "♣", 12),
                    Card.new("J", "♣", 11)
                ]
                test_hand.get_suits
                expect(test_hand.flush?).to be(false)
            end 
        end 

        describe '#straight?' do 
            it 'returns true when the hand is a straight' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♢", 11),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.straight?).to be(true)
            end 

            it 'returns false when the hand is not a straight' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♢", 11),
                    Card.new("5", "♢", 5)
                ]
                test_hand.get_values
                expect(test_hand.straight?).to be(false)
            end 
        end 

        describe '#three_of_a_kind' do 
            it 'returns true when the hand is three of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.three_of_a_kind?).to be(true)
            end 

            it 'returns false when the hand is not three of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.three_of_a_kind?).to be(false)
            end 
        end 

        describe '#two_pair' do 
            it 'returns true when the hand has two pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("4", "♢", 4),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.two_pair?).to be(true)
            end 

            it 'returns false the hand does not have two pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("3", "♢", 3),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.two_pair?).to be(false)
            end 
        end 

        describe '#one_pair' do 
            it 'returns true when the hand has one pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.one_pair?).to be(true)
            end 

            it 'returns false when the hand does not have one pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("4", "♡", 4),
                    Card.new("3", "♢", 3)
                ]
                test_hand.get_values
                expect(test_hand.one_pair?).to be(false)
            end 
        end 
    end 

    context "when calculating a hand's rank" do 
        describe '#calculate' do 
            it 'returns 1 when the hand is a straight flush' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♢", 11),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_suits
                test_hand.get_values
                expect(test_hand.calculate).to eq(1)
            end 

            it 'returns 2 when the hand is four of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("10", "♠", 10),
                    Card.new("Q", "♢", 12),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(2)
            end 

            it 'returns 3 when the hand is a full house' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("9", "♢", 9),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(3)
            end 

            it 'returns 4 when the hand is a flush' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♣", 9),
                    Card.new("2", "♣", 2),
                    Card.new("Q", "♣", 12),
                    Card.new("J", "♣", 11)
                ]
                test_hand.get_suits
                expect(test_hand.calculate).to eq(4)
            end 

            it 'returns 5 when the hand is a straight' do 
                test_hand.hand = [
                    Card.new("A", "♢", 14), 
                    Card.new("K", "♢", 13),
                    Card.new("Q", "♢", 12),
                    Card.new("J", "♣", 11),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(5)
            end 

            it 'returns 6 when the hand is three of a kind' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("10", "♡", 10),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(6)
            end 
            
            it 'returns 7 when the hand has two pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("4", "♢", 4),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(7)
            end 

            it 'returns 8 when the hand has one pair' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("4", "♡", 4),
                    Card.new("10", "♢", 10)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(8)
            end 

            it 'returns 9 when the hand has a high card' do 
                test_hand.hand = [
                    Card.new("10", "♣", 10), 
                    Card.new("9", "♠", 9),
                    Card.new("8", "♢", 8),
                    Card.new("4", "♡", 4),
                    Card.new("3", "♢", 3)
                ]
                test_hand.get_values
                expect(test_hand.calculate).to eq(9)
            end 
        end 
    end     
end 


