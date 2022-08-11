require 'rspec'
require 'active_support/inflector'
require 'aa_questions'
require 'questions.db'

describe User do 

    before(:each) { questions_database = QuestionsDatabase.new }

    describe "find_by_name" do 
        it "finds a user by first and last name" do 
            user = User.find_by_name("Jake", "Shapiro")
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 
    end 
    
end 