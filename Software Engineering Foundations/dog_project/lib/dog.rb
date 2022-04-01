
class Dog 

    def initialize(name, breed, age, bark, favorite_foods)
        @name = name 
        @breed = breed 
        @age = age 
        @bark = bark 
        @favorite_foods = favorite_foods
    end 

    def name 
        @name
    end 

    def breed 
        @breed 
    end 

    def age
        @age
    end 

    def age=(num)
        @age = num 
    end 

    def bark 
        if @age > 3 
            @bark.upcase 
        else 
            @bark.downcase 
        end 
    end 

    def favorite_foods
        @favorite_foods
    end 

    #returns boolean indicating whether given food is part of Dog's favorite foods. accounts for any kinds of capitaliztion.
    def favorite_food?(food)
        @fav_foods_lwr_caps = @favorite_foods.map { |food| food.downcase }
        @fav_foods_lwr_caps.include?(food.downcase)
    end 

end 


