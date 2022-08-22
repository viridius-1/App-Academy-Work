class Toy < ApplicationRecord
    # def dog 
    #     Dog.find(dog_id)
    # end 

    belongs_to(:dog, {
        primary_key: :id, #Dog's id 
        foreign_key: :dog_id, #Toy's table 
        class_name: :Dog 
    })
end 