require 'rspec'
require 'deck'

describe Deck do 
    subject(:test_deck) { Deck.new }

    describe '#card_symbols' do 
        it "loads a full deck" do 
            expect(test_deck.cards.sort).to eq(["10♠", "10♡", "10♢", "10♣", "2♠", "2♡", "2♢", "2♣", "3♠", "3♡", "3♢", "3♣", "4♠", "4♡", "4♢", "4♣", "5♠", "5♡", "5♢", "5♣", "6♠", "6♡", "6♢", "6♣", "7♠", "7♡", "7♢", "7♣", "8♠", "8♡", "8♢", "8♣", "9♠", "9♡", "9♢", "9♣", "A♠", "A♡", "A♢", "A♣", "J♠", "J♡", "J♢", "J♣", "K♠", "K♡", "K♢", "K♣", "Q♠", "Q♡", "Q♢", "Q♣"])
        end 
    end 

    describe '#shuffle_cards' do 
        it "shuffles cards" do 
            expect(test_deck.shuffle_cards).to_not eq(test_deck) 
        end 
    end 

    context 'when dealing cards' do 
        it 'deals cards' do 
            expect(test_deck.deal(5).length).to eq(5)
        end 

        it "doesn't retain the dealt cards" do 
            test_deck.deal(5)
            expect(test_deck.deck.length).to eq(47)
        end 
    end 
end 



