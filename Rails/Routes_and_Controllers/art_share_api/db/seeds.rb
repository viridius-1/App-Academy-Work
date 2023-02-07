# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts "Loading Users..."
User.destroy_all 
user1 = User.create(username: "Jake")
user2 = User.create(username: "Ann")
user3 = User.create(username: "Mary")

puts "Loading Artworks..."
Artwork.destroy_all
#Jake's Art 
artwork1 = Artwork.create(title: "Jake Art1", image_url: "Jake Art1 URL", artist_id: user1.id)
artwork2 = Artwork.create(title: "Jake Art2", image_url: "Jake Art2 URL", artist_id: user1.id)
artwork3 = Artwork.create(title: "Jake Art3", image_url: "Jake Art3 URL", artist_id: user1.id)
#Ann's Art 
artwork4 = Artwork.create(title: "Ann Art1", image_url: "Ann Art1 URL", artist_id: user2.id)
artwork5 = Artwork.create(title: "Ann Art2", image_url: "Ann Art2 URL", artist_id: user2.id)
artwork6 = Artwork.create(title: "Ann Art3", image_url: "Ann Art3 URL", artist_id: user2.id)
#Mary's Art 
artwork7 = Artwork.create(title: "Mary Art1", image_url: "Mary Art1 URL", artist_id: user3.id)
artwork8 = Artwork.create(title: "Mary Art2", image_url: "Mary Art2 URL", artist_id: user3.id)
artwork9 = Artwork.create(title: "Mary Art3", image_url: "Mary Art3 URL", artist_id: user3.id)

puts "Loading ArtworkShares..."
ArtworkShare.destroy_all
#Share Jake's Art with Ann 
artwork_share1 = ArtworkShare.create(artwork_id: artwork1.id, viewer_id: user2.id)
artwork_share2 = ArtworkShare.create(artwork_id: artwork2.id, viewer_id: user2.id)
artwork_share3 = ArtworkShare.create(artwork_id: artwork3.id, viewer_id: user2.id)
#Share Jake's Art with Mary 
artwork_share4 = ArtworkShare.create(artwork_id: artwork1.id, viewer_id: user3.id)
artwork_share5 = ArtworkShare.create(artwork_id: artwork2.id, viewer_id: user3.id)
artwork_share6 = ArtworkShare.create(artwork_id: artwork3.id, viewer_id: user3.id)
#Share Ann's Art with Jake
artwork_share7 = ArtworkShare.create(artwork_id: artwork4.id, viewer_id: user1.id)
artwork_share8 = ArtworkShare.create(artwork_id: artwork5.id, viewer_id: user1.id)
artwork_share9 = ArtworkShare.create(artwork_id: artwork6.id, viewer_id: user1.id)
#Share Ann's Art with Mary
artwork_share10 = ArtworkShare.create(artwork_id: artwork4.id, viewer_id: user3.id)
artwork_share11 = ArtworkShare.create(artwork_id: artwork5.id, viewer_id: user3.id)
artwork_share12 = ArtworkShare.create(artwork_id: artwork6.id, viewer_id: user3.id)
#Share Mary's Art with Jake
artwork_share13 = ArtworkShare.create(artwork_id: artwork7.id, viewer_id: user1.id)
artwork_share14 = ArtworkShare.create(artwork_id: artwork8.id, viewer_id: user1.id)
artwork_share15 = ArtworkShare.create(artwork_id: artwork9.id, viewer_id: user1.id)
#Share Mary's Art with Ann
artwork_share16 = ArtworkShare.create(artwork_id: artwork7.id, viewer_id: user2.id)
artwork_share17 = ArtworkShare.create(artwork_id: artwork8.id, viewer_id: user2.id)
artwork_share18 = ArtworkShare.create(artwork_id: artwork9.id, viewer_id: user2.id)

