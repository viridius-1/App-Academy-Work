# == Schema Information
#
# Table name: dogs
#
#  id       :integer(8)      not null, primary key
#  name     :string          not null
#  house_id :integer(4)      not null

class Dog < ApplicationRecord 
    validates :name, presence: true 
    validate :check_name_length

    belongs_to :house,
        primary_key: :id, #House's id  
        foreign_key: :house_id,
        class_name: :House  

    has_many :toys, 
        primary_key: :id, #dog's id
        foreign_key: :dog_id, 
        class_name: :Toy

    def self.lookup_name_in_ms(name)
        start = Time.now 
        Dog.where(name: :name)
        (Time.now - start) * 1000 
    end 

    def check_name_length 
        unless self.name.length >= 4 
            errors[:name] << "must be at least 4 characters long."
        end 
    end 
    
end 

