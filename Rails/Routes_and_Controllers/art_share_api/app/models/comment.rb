# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  author_id  :integer          not null
#  artwork_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text             not null

class Comment < ApplicationRecord 
    validates :author_id, :artwork_id, :body, presence: true 

    belongs_to :author, 
        primary_key: :id, 
        foreign_key: :author_id, #comments table
        class_name: :User

    belongs_to :artwork, 
        primary_key: :id, 
        foreign_key: :artwork_id, #comments table
        class_name: :Artwork
end 
