# == Schema Information
#
# Table name: users
#
#  id       :integer(8)      not null, primary key
#  username :string          not null

class User < ApplicationRecord 
    validates :username, uniqueness: true, presence: true 
end 



