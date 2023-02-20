class User < ApplicationRecord 
    validates :name, :location, presence: true
end 