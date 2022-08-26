# == Schema Information
#
# Table name: houses
#
#  id   :integer(8)      not null, primary key
#  name :string          not null

class House < ApplicationRecord 
    has_many :dogs, 
        primary_key: :id, #house's id
        foreign_key: :house_id, #dogs table 
        class_name: :Dog 

    # def toys 
    #     toys = []
    #     dogs.each { |dog| toys.concat(dog.toys) } 
    #     toys 
    # end 

    has_many :toys, 
        through: :dogs, 
        source: :toys         
end 
