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
end


