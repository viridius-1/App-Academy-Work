class GuessingGame

    #accept min and max numbers 
    def initialize(min, max)
        @min = min 
        @max = max 
        @secret_num = rand(min..max)
        @num_attempts = 0 
        @game_over = false 
    end 

    #returns number of attempts 
    def num_attempts
        @num_attempts
    end 

    #returns game over status 
    def game_over? 
        @game_over
    end 

    #checks num, increments attempts, sets game over status to true if number equals secret number
    def check_num(num)
        @num_attempts += 1 
        if num == @secret_num
            @game_over = true 
            print "you win"
        elsif num > @secret_num 
            print "too big"
        elsif num < @secret_num 
            print "too small"
        end 
    end 

    #asks user for number and checks number 
    def ask_user
        print "enter a number "
        user_num = gets.chomp.to_i
        check_num(user_num)
    end 

end 



