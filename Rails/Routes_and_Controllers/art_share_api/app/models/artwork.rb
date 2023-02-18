# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  favorite   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Artwork < ApplicationRecord 
    validates :title, :image_url, :artist_id, presence: true 
    validates :image_url, uniqueness: true 
    validates :artist_id, uniqueness: { scope: :title, message: "Combination of Artist ID and Title must be unique." }

    def self.artworks_for_user_id(user_id)
        user = User.find(user_id)
        user.artworks + user.shared_artworks
    end 

    belongs_to :artist, 
        primary_key: :id, 
        foreign_key: :artist_id, #artworks table
        class_name: :User

    has_many :shares, 
        primary_key: :id,  
        foreign_key: :artwork_id, #artwork_shares table  
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :comments, 
        primary_key: :id, 
        foreign_key: :artwork_id, #comments table
        class_name: :Comment,
        inverse_of: :artwork,
        dependent: :destroy 

    has_many :likes, as: :likeable

    has_many :shared_viewers, 
        through: :shares, 
        source: :viewer  

    has_many :likers,
        through: :likes, 
        source: :liker
end 

