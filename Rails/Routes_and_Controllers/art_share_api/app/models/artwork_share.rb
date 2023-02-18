# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  viewer_id  :integer          not null
#  artwork_id :integer          not null
#  favorite   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null

class ArtworkShare < ApplicationRecord 
    after_create do 
        ArtworkShare.validates :artwork_id, :viewer_id, presence: true 
        ArtworkShare.validates :artwork_id, uniqueness: { scope: :viewer_id, message: "A user can't have a single artwork shared with them more than once." }
    end 

    belongs_to :artwork, 
        primary_key: :id, 
        foreign_key: :artwork_id, #artwork_shares table
        class_name: :Artwork, 
        inverse_of: :shares

    belongs_to :viewer, 
        primary_key: :id, 
        foreign_key: :viewer_id, #artwork_shares table
        class_name: :User, 
        inverse_of: :views
end 
