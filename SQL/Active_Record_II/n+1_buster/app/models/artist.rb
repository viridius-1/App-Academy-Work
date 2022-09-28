# == Schema Information
#
# Table name: artists
#
#  id         :integer(8)      not null, primary key
#  name       :string          not null
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id, #albums table
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  #counts all the tracks on each album by a given artist. doesn't use a n + 1 query. 
  def better_tracks_query
    tracks_count = {}
    album_titles_and_tracks = albums.select('albums.title', 'COUNT(*) AS tracks_ct').joins(:tracks).group('albums.title').order('tracks_ct DESC')
    album_titles_and_tracks.each { |album| tracks_count[album.title] = album.tracks_ct }
    tracks_count
  end
end



