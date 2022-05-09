require 'rspec'
require 'card'

describe Card do
    subject(:card) { Card.new("K", "\u2663", 13) }

    describe 'suit' do 
        it "returns a card's suit" do 
            expect(card.suit).to eq("\u2663")
        end 
    end 

    describe '#symbol' do 
        it "returns a card's symbol" do 
            expect(card.symbol).to eq("#{"K"}#{"\u2663"}")
        end 
    end 

    describe '#type' do 
        it "returns a card's type" do 
            expect(card.type).to eq("K")
        end 
    end 

    describe '#value' do 
        it "returns a card's value" do 
            expect(card.value).to eq(13) 
        end    
    end  
end 

