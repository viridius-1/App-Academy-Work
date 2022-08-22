# == Schema Information
#
# Table name: dogs
#
#  id   :integer(8)      not null, primary key
#  name :string          not null

class Dog < ApplicationRecord 
    validates :name, presence: true 
    validate :check_name_length

    def check_name_length 
        unless self.name.length >= 4 
            errors[:name] << "must be at least 4 characters long."
        end 
    end 

    # def toys 
    #     Toy.where({ dog_id: self.id })
    # end 

    has_many(:toys, {
        primary_key: :id, #dog's id
        foreign_key: :dog_id, 
        class_name: :Toy
    })
end 

