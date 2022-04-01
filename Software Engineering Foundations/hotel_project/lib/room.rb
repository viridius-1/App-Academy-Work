class Room 

    def initialize(capacity)
        @capacity = capacity 
        @occupants = []
    end 

    def capacity
        @capacity
    end 

    def occupants
        @occupants
    end 

    def full? 
        if occupants.length < capacity 
            false 
        else 
            true 
        end 
    end 

    def available_space
        @capacity - @occupants.length 
    end 

    def add_occupant(occupant)
        if !self.full? 
            @occupants << occupant 
            true 
        else 
            false 
        end 
    end 

end 