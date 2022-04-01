class Item 

    attr_accessor :title, :description 

    attr_reader :deadline, :done

    def self.valid_date?(date_string)
        arr = date_string.split('-')

        #check year 
        arr[0].each_char { |char| return false if char.ord < '0'.ord || char.ord > '9'.ord }  
        
        #check month 
        return false if arr[1].to_i < 1 || arr[1].to_i > 12 

        #check day 
        return false if arr[2].to_i < 1 || arr[2].to_i > 31  

        true 
    end 

    def initialize(title, deadline, description)
        if Item.valid_date?(deadline)
            @title = title 
            @deadline = deadline 
            @description = description 
            @done = []
        else 
            raise "Invalid date."
        end 
    end 

    def deadline=(new_deadline)
        if Item.valid_date?(new_deadline)
            @deadline = new_deadline 
        else 
            raise "Invalid date."
        end 
    end 

    #method flip's the item's current state 
    def toggle  
        checkmark = "\u2713"
        if @done == [] 
            @done = [checkmark] 
        else 
            @done = [] 
        end 
    end 

end 