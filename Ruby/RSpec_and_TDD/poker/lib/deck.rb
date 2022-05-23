require_relative 'card'

class Deck 

    attr_reader :card_types, :deck, :suits 

    def initialize 
        @card_types = {
        'A' => 14, 
        'K' => 13, 
        'Q' => 12, 
        'J' => 11,
        '10' => 10, 
        '9' => 9, 
        '8' => 8, 
        '7' => 7, 
        '6' => 6, 
        '5' => 5, 
        '4' => 4, 
        '3' => 3, 
        '2' => 2
        }
        @suits = ["\u2660", "\u2663", "\u2661", "\u2662"]
        fill_deck 
    end 

    def deal(num)
        dealt_cards = []
        shuffle_cards

        num.times do 
            dealt_card = deck.sample 
            dealt_cards << dealt_card
            deck.delete(dealt_card) 
        end 

        dealt_cards
    end 

    #private 

    def fill_deck
        @deck = []
        card_types.each do |card, value| 
            suits.each { |suit| @deck << Card.new(card, suit, value) } 
        end
    end 

    def shuffle_cards
        deck.shuffle!
    end 

    def cards
        cards_in_deck = []
        deck.each { |card| cards_in_deck << card.symbol }
        cards_in_deck 
    end

end 

