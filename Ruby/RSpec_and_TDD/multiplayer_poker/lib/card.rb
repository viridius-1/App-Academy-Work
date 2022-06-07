class Card 

    attr_reader :suit, :symbol, :type, :value 

    def initialize(type, suit, value)
        @type = type 
        @symbol = "#{type}#{suit}"
        @suit = suit 
        @value = value 
    end 

end 