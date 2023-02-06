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
user2 = User.create(username: "Jake")
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