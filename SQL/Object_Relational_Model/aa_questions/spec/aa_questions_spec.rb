require 'rspec'
require 'active_support/inflector'
require_relative '../aa_questions'
require 'byebug'

describe User do 

    describe "::find_by_name" do 
        before(:each) { QuestionsDatabase.reset! }
        after(:each) { QuestionsDatabase.reset! }

        it "finds a user by first and last name" do 
            user = User.find_by_name("Jake", "Shapiro")
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 

        it "hits the database 1 time" do 
           # debugger 
            expect(QuestionsDatabase).to receive(:execute).with("SELECT * FROM users WHERE fname = 'Jake' AND lname = 'Shapiro'") 
            User.find_by_name("Jake", "Shapiro")
        end 
    end 
    
end 