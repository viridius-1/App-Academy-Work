class Flight 

    attr_reader :passengers
    
    def initialize(flight, capacity)
        @flight_number = flight 
        @capacity = capacity 
        @passengers = []
    end 

    def full? 
        if @passengers.length == @capacity 
            true 
        elsif @passengers.length < @capacity 
            false 
        end 
    end 

    def board_passenger(passenger)
        @passengers << passenger if passenger.has_flight?(@flight_number) && !full? 
    end 

    def list_passengers
        pass_names = []
        @passengers.each { |passenger| pass_names << passenger.name }
        pass_names
    end 

    def [](idx)
        @passengers[idx]
    end 

    def <<(passenger)
        board_passenger(passenger)
    end 

end 