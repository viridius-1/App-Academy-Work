require 'rspec'
require 'player'
require 'byebug'

describe Player do
    let(:deck) { Deck.new }
    let(:hand) { double('hand') }
    let(:card) { double('card') }
    subject(:player) { Player.new('Jake', deck, 10, 0) }  
    before(:each) { player.deal_cards } 

    context 'when game starts' do 
        it 'has chips' do 
            expect(player.chips).to eq(10)
        end 

        it "returns the player's name" do 
            expect(player.name).to eq('Jake')
        end 
    end 

    describe '#receive_chips' do 
        it 'increases the chip amount' do 
            player.chips = 10 
            player.receive_chips(1)
            expect(player.chips).to eq(11)
        end 
    end 

    context 'when dealing cards' do 
        describe '#deal_cards' do 
            it 'has a hand' do 
                expect(player.hand).to_not eq(nil)
            end 

            it 'has 5 cards' do 
                expect(player.hand.hand.length).to eq(5)
            end 
        end 
    end 
    
    context 'when players are betting' do 
        describe '#illegal_characters?' do 
            it 'returns true when a bet has illegal characters' do 
                expect(player.illegal_characters?('5t')).to be(true)
            end 

            it 'returns false when a bet has no illegal characters' do 
            expect(player.illegal_characters?('5')).to be(false)
            end 
        end 

        describe '#legal_bet?' do 
            it 'returns true for a legal bet' do 
                expect(player.legal_bet?('5')).to be(true)
            end 

            it 'returns false for a bet that is not legal' do 
                expect(player.legal_bet?('12')).to be(false)
            end 
        end 
        
        
        it 'can fold' do 
            player.fold = true 
            expect(player.fold).to be(true)
        end 

        # it 'can see the current bet' do 
        #     player.fold = false 
        #     player.see = true 
        #     expect(player.see).to be(true)
        # end 

        # it 'can raise' do 
        #     player.see = false 
        #     player.raise(3)
        #     expect(player.chips).to eq(7) 
        # end 

        # describe '#bet' do 
        #     it 'decreases the chip amount' do 
        #         player.bet(1)
        #         expect(player.chips).to eq(9)
        #     end 
        # end 
    end 
    
    context 'when exchanging cards' do  
        describe '#discard' do 
            it 'can discard a card' do 
                allow(hand).to receive(:remove_card).with(2)
                expect { player.discard(2) }.to_not raise_error
            end 
        end 

        describe '#receive_card' do 
            it 'can receive a card' do 
                allow(hand).to receive(:add_card).with(card)
                expect { player.receive_card(card) }.to_not raise_error
            end 
        end 
    end 
end 