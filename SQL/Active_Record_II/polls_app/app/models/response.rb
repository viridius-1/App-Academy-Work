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
    validate :not_duplicate_response, :not_response_to_own_poll

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

    def responses 
        question.responses
    end 

    def sibling_responses
        question.responses.where.not(id: self.id)
    end 

    def respondent_already_answered?(respondent_id) 
        if self.id == respondent_id
            responses.exists?(user_id: respondent_id)
        else 
            sibling_responses.exists?(user_id: respondent_id)  
        end 
    end 

    def not_duplicate_response 
        errors[:user_id] << "user can't answer a question more than once." if respondent_already_answered?(self.user_id)   
    end 

    def not_response_to_own_poll
        errors[:user_id] << "user can't answer a question of its own poll." if answer_choice.question.poll.user_id == user_id 
    end 

end


