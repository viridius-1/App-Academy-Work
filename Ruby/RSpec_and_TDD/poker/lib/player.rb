require_relative 'hand'

class Player 

    attr_reader :chips, :hand, :name

    def initialize(name, deck)
        @name = name 
        @chips = 10 
        @hand = Hand.new(deck)
    end 

 




end 


# def raise(amount)
#     chips -= amount 
# end 

#player discards a card 
    #hand.remove_card 