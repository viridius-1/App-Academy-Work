# == Schema Information
#
# Table name: toys
#
#  id     :integer(8)      not null, primary key
#  name   :string          not null
#  dog_id :integer(4)      not null
#  color  :string          not null

class Toy < ApplicationRecord
    belongs_to :dog, 
        primary_key: :id, #Dog's id 
        foreign_key: :dog_id, #Toy's table 
        class_name: :Dog 
    
    has_many :houses,  
        through: :dog, 
        source: :house 
end 




