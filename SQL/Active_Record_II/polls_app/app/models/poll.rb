# == Schema Information
#
# Table name: polls
#
#  id    :integer(8)      not null, primary key
#  title :string          not null

class Poll < ApplicationRecord 
    validates :title, presence: true 
end 

