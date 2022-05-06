require 'rspec'
require 'hand'

describe Hand do 
    describe '#calculate' do 
        let(:straight_flush) do Hand.new(
            {
                "A♢"=>["A", "♢", 14], 
                "K♢"=>["K", "♢", 13], 
                "Q♢"=>["Q", "♢", 12], 
                "J♢"=>["J", "♢", 11], 
                "10♢"=>["10", "♢", 10]
            }
        )    
        end 
        it 'identifies a straight flush' do 
            expect(straight_flush.calculate).to eq(1)
        end 

        let(:four_of_a_kind) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "K♠"=>["K", "♠", 13], 
                "K♡"=>["K", "♡", 13], 
                "K♣"=>["K", "♣", 13], 
                "10♠"=>["10", "♠", 10]
            }
        )  
        end 
        it 'identifies four of a kind' do 
            expect(four_of_a_kind.calculate).to eq(2)
        end 

        let(:full_house) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "K♠"=>["K", "♠", 13], 
                "K♡"=>["K", "♡", 13], 
                "10♢"=>["10", "♢", 10], 
                "10♠"=>["10", "♠", 10]
            }
        )  
        end 
        it 'identifies a full house' do 
            expect(full_house.calculate).to eq(3)
        end 

        let(:flush) do Hand.new(
            {
                "K♢"=>["K", "♢", 13],  
                "10♢"=>["10", "♢", 10], 
                "5♢"=>["5", "♢", 5], 
                "3♢"=>["3", "♢", 3],
                "J♢"=>["J", "♢", 11]
            }
        ) 
        end 
        it 'identifies a flush' do 
            expect(flush.calculate).to eq(4)
        end 

        let(:straight) do Hand.new(
            {
                "K♢"=>["K", "♢", 13],
                "Q♠"=>["Q", "♠", 12],
                "J♢"=>["J", "♢", 11],  
                "10♢"=>["10", "♢", 10], 
                "9♡"=>["9", "♡", 9]
            }
        ) 
        end 
        it 'identifies a straight' do 
            expect(straight.calculate).to eq(5)
        end 

        let(:three_of_a_kind) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "K♠"=>["K", "♠", 13], 
                "K♡"=>["K", "♡", 13],
                "10♢"=>["10", "♢", 10], 
                "9♡"=>["9", "♡", 9]
            }
        ) 
        end 
        it 'identifies three of a kind' do 
            expect(three_of_a_kind.calculate).to eq(6)
        end 

        let(:two_pair) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "K♠"=>["K", "♠", 13], 
                "3♠"=>["3", "♠", 3],
                "3♣"=>["3", "♣", 3], 
                "10♢"=>["10", "♢", 10], 
            }
        ) 
        end 
        it 'identifies two pair' do 
            expect(two_pair.calculate).to eq(7)
        end 

        let(:one_pair) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "K♠"=>["K", "♠", 13], 
                "5♣"=>["5", "♣", 5],
                "3♣"=>["3", "♣", 3], 
                "10♢"=>["10", "♢", 10], 
            }
        ) 
        end 
        it 'identifies one pair' do 
            expect(one_pair.calculate).to eq(8)
        end 

        let(:high_card) do Hand.new(
            {
                "K♢"=>["K", "♢", 13], 
                "9♣"=>["9", "♣", 9], 
                "5♣"=>["5", "♣", 5],
                "3♣"=>["3", "♣", 3], 
                "10♢"=>["10", "♢", 10], 
            }
        ) 
        end 
        it 'identifies a high card' do 
            expect(high_card.calculate).to eq(9)
        end 
    end 

    describe '#remove_card' do 
        it 'removes 3 cards from a hand' do 
            high_card.remove_card("9♣")
            high_card.remove_card("5♣")
            high_card.remove_card("3♣")
            expect(high_card).to eq({
                "K♢"=>["K", "♢", 13],  
                "10♢"=>["10", "♢", 10] 
            })
        end 
    end 

    describe '#add_card' do 
        it 'adds 3 cards to a hand' do 
            high_card.add_card("4♣"=>["4", "♣", 4])
            high_card.add_card("2♢"=>["2", "♢", 2])
            high_card.add_card("6♡"=>["6", "♡", 6])
             expect(high_card).to eq({
                "K♢"=>["K", "♢", 13],  
                "10♢"=>["10", "♢", 10], 
                "4♣"=>["4", "♣", 4], 
                "2♢"=>["2", "♢", 2],
                "6♡"=>["6", "♡", 6]
            })
        end 
    end 
end 


