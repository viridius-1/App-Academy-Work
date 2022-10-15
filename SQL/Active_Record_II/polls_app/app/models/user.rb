# == Schema Information
#
# Table name: users
#
#  id       :integer(8)      not null, primary key
#  username :string          not null

class User < ApplicationRecord 
    validates :username, uniqueness: true, presence: true 

    has_many :authored_polls, 
        class_name: :Poll,
        foreign_key: :user_id, #polls table 
        primary_key: :id

    has_many :responses, 
        class_name: :Response, 
        foreign_key: :user_id, #responses table  
        primary_key: :id 
end 



