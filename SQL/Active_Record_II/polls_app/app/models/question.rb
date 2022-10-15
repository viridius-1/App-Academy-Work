# == Schema Information
#
# Table name: questions
#
#  id   :integer(8)      not null, primary key
#  text :text            not null

class Question < ApplicationRecord 
    validates :text, presence: true 
end 


