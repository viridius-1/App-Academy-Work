require "byebug"
require_relative "code"


class Mastermind 

    def initialize(length)
        @secret_code = Code.random(length)
    end 

    def print_matches(code)
        puts "Exact Matches: #{@secret_code.num_exact_matches(code)}" 
        puts "Near Matches: #{@secret_code.num_near_matches(code)}" 
    end 

    def ask_user_for_guess
        puts "Enter a code"
        input = gets.chomp
        input = Code.from_string(input)
        print_matches(input)
        @secret_code == input 
    end 






end 
