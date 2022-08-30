# == Schema Information
#
# Table name: people
#
#  id       :integer(8)      not null, primary key
#  name     :string          not null
#  house_id :integer(4)      not null


class Person < ApplicationRecord
    validates :name, :house_id, presence: true 

    belongs_to :house, 
        primary_key: :id,   
        foreign_key: :house_id, #people table 
        class_name: :House 
end 

