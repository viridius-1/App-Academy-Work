require_relative "tile.rb"

class Player 

    attr_reader :name 
    attr_accessor :user_position, :user_value 

    def initialize(name)
        @name = name 
        @user_position = nil 
        @user_value = nil 
    end 

    #method turns the @user_position string to an array 
    def turn_user_positionstring_to_arrayposition
        @user_position.split('').map { |el| el.to_i }
    end 

    def valid_position?
        return false if @user_position.length != 2 
        @user_position.split('').all? { |el| el.ord >= 48 && el.ord <= 56}
    end 

    def valid_value? 
        return false if @user_value.length != 1  
        @user_value.ord >= 49 && @user_value.ord <= 57 
    end 

    def prompt_for_position
        valid = false 
        while !valid
            puts "#{@name}, enter a position on the board. Format it like this example. --> (Example: 00)"
            @user_position = gets.chomp 
            if valid_position?
                valid = true 
            else
                puts "\nInvalid position!"
            end 
        end 
        @user_position = turn_user_positionstring_to_arrayposition
    end 

    def prompt_for_value
        valid = false 
        while !valid
            print "Enter a value for position #{@user_position} "
            @user_value = gets.chomp 
            if valid_value? 
                valid = true 
            else   
                puts "\nInvalid value! Values must be between 1 and 9."
            end 
        end 
    end 

end 