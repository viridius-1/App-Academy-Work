require_relative "board.rb"
require_relative "game.rb"

class HumanPlayer 

    attr_reader :mark 

    def initialize(mark_value)
        @mark = mark_value 
    end 

    def get_position(legal_positions, board_length, board)
        correct = false
        
        while !correct 
            puts "#{self.class} #{@mark}, enter a position in the format, 'row col'. Separate the numbers with a space. The numbers should be greater than or equal to 0 and less than or equal to #{board_length - 1}."
            user_pos = gets.chomp.split.map! { |el| el.to_i }

            if legal_positions.include?(user_pos)
                correct = true 
            else 
                puts "\nERROR - Invalid entry"
                board.print_board
            end 
        end 
        user_pos 
    end 

end 