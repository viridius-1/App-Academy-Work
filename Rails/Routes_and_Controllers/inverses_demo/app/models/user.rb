# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class User < ApplicationRecord
    validates :username, presence: true 

    has_many :posts 

    has_many :comments, 
        foreign_key: :author_id, #comments table
        inverse_of: :author

    has_many :likes

    has_many :liked_posts, 
        through: :likes, 
        source: :post
end 
