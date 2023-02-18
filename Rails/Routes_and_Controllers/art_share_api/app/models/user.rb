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

    has_many :comments, 
        primary_key: :id, 
        foreign_key: :author_id, #comments table
        class_name: :Comment, 
        inverse_of: :author,
        dependent: :destroy

    has_many :likes, 
        primary_key: :id, 
        foreign_key: :user_id, #likes table 
        class_name: :Like,  
        inverse_of: :liker, 
        dependent: :destroy

    has_many :collections, 
        primary_key: :id, 
        foreign_key: :user_id, #collections table 
        class_name: :Collection,
        inverse_of: :collector,
        dependent: :destroy

    has_many :shared_artworks, 
        through: :views, 
        source: :artwork
    
    def liked_items(item)
        items_liked_by_user = []
        likes.each { |like| items_liked_by_user << like if like.likeable_type == item } 
        items_liked_by_user
    end 

    def liked_comments
        liked_items("Comment")
    end 

    def liked_artworks
        liked_items("Artwork")
    end 

    def collection_list 
        get_collection_list(collections)
    end 
end 