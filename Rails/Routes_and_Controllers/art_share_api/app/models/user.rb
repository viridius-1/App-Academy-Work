# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 

    has_many :artworks, 
        primary_key: :id, 
        foreign_key: :artist_id, #artworks table 
        class_name: :Artwork, 
        inverse_of: :artist,
        dependent: :destroy

    has_many :views, 
        primary_key: :id, 
        foreign_key: :viewer_id, #artwork_shares table 
        class_name: :ArtworkShare,
        inverse_of: :viewer,
        dependent: :destroy

    has_many :shared_artworks, 
        through: :views, 
        source: :artwork,
        dependent: :destroy  
end 