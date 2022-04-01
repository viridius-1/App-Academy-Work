class HumanPlayer 

    attr_reader :mark 

    def initialize(mark_value)
        @mark = mark_value 
    end 

    def get_position 
        correct = false
        lwr_band = 0.to_s.ord 
        upr_band = 2.to_s.ord
        
        while !correct 
            puts "Player #{@mark}, enter a position in the format, row col. Be sure to separate the numbers with a space."
            user_pos = gets.chomp.split

            #eval for letters 
            ltr_eval = get_ltr_eval(user_pos, lwr_band, upr_band)

            if user_pos.length == 2 && ltr_eval 
                user_pos.map! { |el| el.to_i }
                correct = true 
            else 
                puts "\nERROR - Invalid entry\n"
            end 
        end 
        user_pos 
    end 

    #method returns boolean as to whether the user's entry contains numbers 
    def get_ltr_eval(user_pos, lwr_band, upr_band)
        user_pos.each { |el| return false if el.ord < lwr_band || el.ord > upr_band }  
        true 
    end 

end 