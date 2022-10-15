# == Schema Information
#
# Table name: polls
#
#  id      :integer(8)      not null, primary key
#  title   :string          not null
#  user_id :integer(4)      not null

class Poll < ApplicationRecord 
    validates :title, presence: true 

    belongs_to :author, 
        class_name: :User,
        foreign_key: :user_id, #polls table
        primary_key: :id 

    has_many :questions, 
        class_name: :Question, 
        foreign_key: :poll_id, #questions table
        primary_key: :id 
end 

