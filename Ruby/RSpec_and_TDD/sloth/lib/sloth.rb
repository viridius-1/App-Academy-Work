class Sloth 

    attr_reader :drinks, :foods, :name 
    DIRECTIONS = %W(north, south, east, west)

    def initialize(name) 
        @name = name 
        @foods = []
        @drinks = {}
    end

    def eat(food) 
        foods << food 
    end 

    def drink(beverage, amount)
        drinks[beverage] = amount
    end 

    def run(direction)
        raise ArgumentError unless DIRECTIONS.include?(direction)
        "I'm running #{direction} at .00001 mph."
    end 

    #private 
    def secret
        'Shhh...this is a secret'
    end 

end 