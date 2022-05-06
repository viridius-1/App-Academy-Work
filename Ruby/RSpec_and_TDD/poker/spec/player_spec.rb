require 'rspec'
require 'player'

describe Player do
    subject(:player) { Player.new('Jake') }  

    it 'has chips' do 
        expect(player.chips).to eq(10)
    end 

    context 'when game starts' do 
        it 'has a hand' do 
            expect(player.hand).to_not eq(nil)
        end 

        it 'has 5 cards' do 
            expect(player.hand.length).to eq(5)
        end 
    end 
    
    context 'when players are betting' do 
        it 'can fold' do 
            player.fold = true 
            expect(player.fold).to be(true)
        end 

        it 'can see the current bet' do 
            player.fold = false 
            player.see = true 
            expect(player.see).to be(true)
        end 

        it 'can raise' do 
            player.see = false 
            player.raise(3)
            expect(player.chips).to eq(7) 
        end 

        describe '#bet' do 
            it 'decreases the chip amount' do 
                player.bet(1)
                expect(player.chips).to eq(9)
            end 
        end 

        describe '#receive_chips' do 
            it 'increases the chip amount' do 
                player.receive_chips(1)
                expect(player.chips).to eq(10)
            end 
        end 
    end  
end 