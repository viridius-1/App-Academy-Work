class Tile 

    attr_reader :given 
    attr_accessor :value 

    def initialize(value, given_boolean)
        @value = value 
        @given = given_boolean
    end 

    def to_string 
        if @given 
            no_change_msg
        else 
            @value = @value.to_s
        end 
    end 

    def no_change_msg
        puts "\nThis tile can't be changed."
    end 

end 