# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  viewer_id  :integer          not null
#  artwork_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class ArtworkShare < ApplicationRecord 
    validates :artwork_id, :viewer_id, presence: true 
    validates :artwork_id, uniqueness: { scope: :viewer_id, message: "A user can't have a single artwork shared with them more than once." }

    belongs_to :artwork, 
        primary_key: :id, 
        foreign_key: :artwork_id, #artwork_shares table
        class_name: :Artwork 

    belongs_to :viewer, 
        primary_key: :id, 
        foreign_key: :viewer_id, #artwork_shares table
        class_name: :User
end 
