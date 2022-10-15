# == Schema Information
#
# Table name: questions
#
#  id      :integer(8)      not null, primary key
#  text    :text            not null
#  poll_id :integer(4)      not null

class Question < ApplicationRecord 
    validates :text, presence: true 

    has_many :answer_choices
        class_name: :AnswerChoice, 
        foreign_key: :question_id, #answer_choices table
        primary_key: :id 

    belongs_to :poll, 
        class_name: :Poll, 
        foreign_key: :poll_id, #questions table 
        primary_key: :id 
end 


