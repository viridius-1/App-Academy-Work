require 'drink'

class Dessert 

    attr_reader :amount, :type 

    def initialize(type, amount) 
        raise "amount must be a number" if amount.class != Integer 
        @amount = amount 
        @type = amount > 100 ? "giant #{type}" : type
    end 

    def eat(drink)
        drink.dip(self)
    end 

end 