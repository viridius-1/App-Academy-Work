# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer(8)      not null, primary key
#  text        :text            not null
#  question_id :integer(4)      not null

class AnswerChoice < ApplicationRecord 
    validates :text, presence: true

    belongs_to :question, 
        class_name: :Question, 
        foreign_key: :question_id, #answer_choices table 
        primary_key: :id 

    has_many :responses, 
        class_name: :Response, 
        foreign_key: :answer_choice_id, #responses table 
        primary_key: :id 
end 


