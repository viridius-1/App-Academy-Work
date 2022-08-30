# == Schema Information
#
# Table name: houses
#
#  id      :integer(8)      not null, primary key
#  address :string          not null


class House < ApplicationRecord 
    validates :address, presence: true 

    has_many :residents, 
        primary_key: :id,   
        foreign_key: :house_id, #people table 
        class_name: :Person 
end 

