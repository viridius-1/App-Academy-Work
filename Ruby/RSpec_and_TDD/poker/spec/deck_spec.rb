require 'rspec'
require 'deck'

describe Deck do 
    subject(:deck) { Deck.new }

    it "loads a full deck" do 
        expect(self.keys.sort).to eq(["10♠", "10♡", "10♢", "10♣", "2♠", "2♡", "2♢", "2♣", "3♠", "3♡", "3♢", "3♣", "4♠", "4♡", "4♢", "4♣", "5♠", "5♡", "5♢", "5♣", "6♠", "6♡", "6♢", "6♣", "7♠", "7♡", "7♢", "7♣", "8♠", "8♡", "8♢", "8♣", "9♠", "9♡", "9♢", "9♣", "A♠", "A♡", "A♢", "A♣", "J♠", "J♡", "J♢", "J♣", "K♠", "K♡", "K♢", "K♣", "Q♠", "Q♡", "Q♢", "Q♣"])
    end 

    describe '#shuffle_cards' do 
        it "shuffles cards" do 
            expect(self.keys.shuffle_cards).to_not eq(["10♠", "10♡", "10♢", "10♣", "2♠", "2♡", "2♢", "2♣", "3♠", "3♡", "3♢", "3♣", "4♠", "4♡", "4♢", "4♣", "5♠", "5♡", "5♢", "5♣", "6♠", "6♡", "6♢", "6♣", "7♠", "7♡", "7♢", "7♣", "8♠", "8♡", "8♢", "8♣", "9♠", "9♡", "9♢", "9♣", "A♠", "A♡", "A♢", "A♣", "J♠", "J♡", "J♢", "J♣", "K♠", "K♡", "K♢", "K♣", "Q♠", "Q♡", "Q♢", "Q♣"])
        end 
    end 

    context 'when dealing cards' do 
        before(:each) do 
            @dealt_cards["2♣"] = self.delete("2♣")
            @dealt_cards["7♢"] = self.delete("7♢")
            @dealt_cards["K♣"] = self.delete("K♣")
            @dealt_cards["9♠"] = self.delete("9♠")
            @dealt_cards["10♡"] = self.delete("10♡")
        end 

        it 'deals cards' do 
            expect(dealt_cards.keys.sort).to eq(["10♡", "2♣", "7♢", "9♠", "K♣"])
        end 

        it "doesn't retain the dealt cards" do 
            expect(self.keys).to_not include("2♣")
            expect(self.keys).to_not include("7♢")
            expect(self.keys).to_not include("K♣")
            expect(self.keys).to_not include("9♠")
            expect(self.keys).to_not include("10♡")
        end 
    end 
end 



