require 'rspec'
require 'active_support/inflector'
require_relative '../aa_questions'

describe User do 

    describe "find_by_name" do 
        it "finds a user by first and last name" do 
            user = User.find_by_name("Jake", "Shapiro")
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 
    end 
    
end 