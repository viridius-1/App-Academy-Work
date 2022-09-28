# == Schema Information
#
# Table name: albums
#
#  id         :integer(8)      not null, primary key
#  title      :string          not null
#  artist_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Album < ApplicationRecord
  belongs_to :artist,
    class_name: 'Artist',
    foreign_key: :artist_id, #albums table 
    primary_key: :id

  has_many :tracks,
    class_name: 'Track',
    foreign_key: :album_id, #tracks table 
    primary_key: :id
end



