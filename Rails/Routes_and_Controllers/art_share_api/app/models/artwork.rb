# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord 
    validates :title, :image_url, :artist_id, presence: true 
    validates :image_url, uniqueness: true 
    validates :artist_id, uniqueness: { scope: :title, message: "Combination of Artist ID and Title must be unique."}
end 