# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer(8)      not null, primary key
#  text        :text            not null
#  question_id :integer(4)      not null

class AnswerChoice < ApplicationRecord 
    validates :text, presence: true
end 


