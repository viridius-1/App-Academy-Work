# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Post < ApplicationRecord
    validates :user_id, :title, :body, presence: true 

    belongs_to :user

    has_many :likes, 
        inverse_of: :post

    has_many :likers, 
        through: :likes, 
        source: :user
end 
