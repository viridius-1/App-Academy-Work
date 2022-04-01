class ComputerPlayer 

    attr_reader :mark 

    def initialize(mark_value)
        @mark = mark_value 
    end 

    def get_position(legal_positions)
        pos = legal_positions.sample 
        puts "\nComputer #{@mark} chose position #{pos.first} #{pos.last}."
        pos 
    end 

end 