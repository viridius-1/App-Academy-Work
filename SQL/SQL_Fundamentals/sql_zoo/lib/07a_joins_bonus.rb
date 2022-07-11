# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT 
      artist 
    FROM 
      tracks 
    JOIN
      albums ON tracks.album = albums.asin
    WHERE 
      song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT 
      artist 
    FROM 
      tracks 
    JOIN
      albums ON tracks.album = albums.asin
    WHERE 
      song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT 
      song
    FROM 
      tracks 
    JOIN 
      albums ON tracks.album = albums.asin
    WHERE 
      title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
      SELECT 
        title, COUNT(title)
      FROM 
        albums 
      JOIN 
        tracks ON albums.asin = tracks.album 
      WHERE 
        song LIKE '%Heart%'
      GROUP BY 
        title 
      ORDER BY 
        COUNT(title) DESC, title 
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT 
      title 
    FROM 
      tracks 
    JOIN 
      albums ON tracks.album = albums.asin 
    WHERE 
      song = title 
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT 
      title 
    FROM 
      albums 
    WHERE
      title = artist 
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT 
      tracks.song, COUNT(albums.title)
    FROM 
      albums
    JOIN
      tracks ON albums.asin = tracks.album 
    GROUP BY 
      tracks.song 
    HAVING 
      COUNT(DISTINCT albums.title) > 2  
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT 
      title, price, COUNT(song)
    FROM 
      albums 
    JOIN
      tracks ON albums.asin = tracks.album 
    GROUP BY 
      title, price  
    HAVING  
      price / COUNT(song) < 0.50 
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
    SELECT 
      title, COUNT(song)
    FROM 
      albums 
    JOIN
      tracks ON albums.asin = tracks.album 
    GROUP BY 
      title 
    ORDER BY 
      COUNT(song) DESC, title DESC 
    LIMIT 
      10
  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
    SELECT
      artist, COUNT(DISTINCT title) AS album_count 
    FROM 
      albums 
    JOIN
      styles ON albums.asin = styles.album 
    WHERE 
      style LIKE '%Rock%'  
    GROUP BY 
      artist 
    ORDER BY 
      COUNT(DISTINCT title) DESC
    LIMIT 
      1 
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.
  execute(<<-SQL)
    SELECT
      style, SUM(price) / SUM(album_count) AS avg_price 
    FROM 
      styles
    JOIN 
      --get number of tracks per album
      (SELECT 
        album, COUNT(album) AS album_count 
      FROM
        tracks 
      GROUP BY 
        album) AS num_tracks_per_album ON styles.album = num_tracks_per_album.album
    JOIN 
      albums ON num_tracks_per_album.album = albums.asin
    WHERE
      price IS NOT NULL
    GROUP BY 
      style
    ORDER BY 
      SUM(price) / SUM(album_count) DESC, style ASC
    LIMIT
      5
  SQL
end


#ALISON ARTIST 
puts "ALISON ARTIST"
p alison_artist
puts "-------------------------------------"

#EXODUS ARTIST 
puts "EXODUS ARTIST"
p exodus_artist
puts "-------------------------------------"

#BLUR SONGS 
puts "BLUR SONGS"
p blur_songs
puts "-------------------------------------"

#HEART TRACKS  
puts "HEART TRACKS"
p heart_tracks
puts "-------------------------------------"

#TITLE TRACKS  
puts "TITLE TRACKS"
p title_tracks
puts "-------------------------------------"

#EPONYMOUS ALBUMS 
puts "EPONYMOUS ALBUMS"
p eponymous_albums
puts "-------------------------------------"

#SONG TITLE COUNTS
puts "SONG TITLE COUNTS"
p song_title_counts
puts "-------------------------------------"

#BEST VALUE 
puts "BEST VALUE"
p best_value
puts "-------------------------------------"

#TOP TRACK COUNTS  
puts "TOP TRACK COUNTS"
p top_track_counts
puts "-------------------------------------"

#ROCK SUPERSTARS  
puts "ROCK SUPERSTARS"
p rock_superstars
puts "-------------------------------------"

#EXPENSIVE TASTES 
puts "EXPENSIVE TASTES"
p expensive_tastes
puts "-------------------------------------"
