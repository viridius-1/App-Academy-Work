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

    belongs_to :answer_choice, 
        class_name: :AnswerChoice, 
        foreign_key: :answer_choice_id, #responses table 
        primary_key: :id

    belongs_to :respondent, 
        class_name: :User, 
        foreign_key: :user_id, #responses table 
        primary_key: :id 
end


