# == Schema Information
#
# Table name: responses
#
#  id               :integer(8)      not null, primary key
#  user_id          :integer(4)      not null
#  question_id      :integer(4)      not null
#  answer_choice_id :integer(4)      not null

class Response < ApplicationRecord 
    validates :user_id, :question_id, :answer_choice_id, presence: true 
    validate :not_duplicate_response, :does_not_respond_to_own_poll, :does_not_respond_to_own_poll_version2
    after_destroy :log_destroy_action 

    belongs_to :answer_choice, 
        class_name: :AnswerChoice, 
        foreign_key: :answer_choice_id, #responses table 
        primary_key: :id

    belongs_to :respondent, 
        class_name: :User, 
        foreign_key: :user_id, #responses table 
        primary_key: :id 

    has_one :question, 
        through: :answer_choice,  
        source: :question  

    def log_destroy_action
        puts "Response destroyed."
    end 

    def responses 
        question.responses
    end 

    def sibling_responses
        question.responses.where.not(id: self.id)
    end 

    def sibling_responses_version2 
        Response.joins(answer_choice: :question).where('questions.id': self.question_id).where.not('responses.user_id': self.user_id)
    end 

    def respondent_already_answered?(respondent_id) 
        if self.id == respondent_id || self.id.nil? 
            responses.exists?(user_id: respondent_id)
        else 
            sibling_responses_version2.exists?(user_id: respondent_id)  
        end 
    end 

    def not_duplicate_response 
        errors[:user_id] << "can't answer a question more than once." if respondent_already_answered?(self.user_id)   
    end 

    def does_not_respond_to_own_poll
        errors[:user_id] << "can't answer a question of its own poll." if answer_choice.question.poll.user_id == user_id 
    end 

    def does_not_respond_to_own_poll_version2 
        poll = Poll.joins(questions: :answer_choices).where('polls.user_id': question.poll.id).first 
        errors[:user_id] << "can't answer a question of its own poll." if poll.user_id == self.user_id
    end 

end


