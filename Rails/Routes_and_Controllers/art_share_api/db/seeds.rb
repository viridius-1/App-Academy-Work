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

puts "Loading Comments..."
Comment.destroy_all
#Jake's Comments on Ann's Art
comment1 = Comment.create(author_id: user1.id, artwork_id: artwork4.id, body: "Jake comment on Ann Art1")
comment2 = Comment.create(author_id: user1.id, artwork_id: artwork5.id, body: "Jake comment on Ann Art2")
comment3 = Comment.create(author_id: user1.id, artwork_id: artwork6.id, body: "Jake comment on Ann Art3")
#Jake's Comments on Mary's Art
comment4 = Comment.create(author_id: user1.id, artwork_id: artwork7.id, body: "Jake comment on Mary Art1")
comment5 = Comment.create(author_id: user1.id, artwork_id: artwork8.id, body: "Jake comment on Mary Art2")
comment6 = Comment.create(author_id: user1.id, artwork_id: artwork9.id, body: "Jake comment on Mary Art3")
#Ann's Comments on Jake's Art 
comment7 = Comment.create(author_id: user2.id, artwork_id: artwork1.id, body: "Ann comment on Jake Art1")
comment8 = Comment.create(author_id: user2.id, artwork_id: artwork2.id, body: "Ann comment on Jake Art2")
comment9 = Comment.create(author_id: user2.id, artwork_id: artwork3.id, body: "Ann comment on Jake Art3")
#Ann's Comments on Mary's Art 
comment10 = Comment.create(author_id: user2.id, artwork_id: artwork7.id, body: "Ann comment on Mary Art1")
comment11 = Comment.create(author_id: user2.id, artwork_id: artwork8.id, body: "Ann comment on Mary Art2")
comment12 = Comment.create(author_id: user2.id, artwork_id: artwork9.id, body: "Ann comment on Mary Art3")
#Mary's Comments on Jake's Art 
comment13 = Comment.create(author_id: user3.id, artwork_id: artwork1.id, body: "Mary comment on Jake Art1")
comment14 = Comment.create(author_id: user3.id, artwork_id: artwork2.id, body: "Mary comment on Jake Art2")
comment15 = Comment.create(author_id: user3.id, artwork_id: artwork3.id, body: "Mary comment on Jake Art3")
#Mary's Comments on Ann's Art 
comment16 = Comment.create(author_id: user3.id, artwork_id: artwork4.id, body: "Mary comment on Ann Art1")
comment17 = Comment.create(author_id: user3.id, artwork_id: artwork5.id, body: "Mary comment on Ann Art2")
comment18 = Comment.create(author_id: user3.id, artwork_id: artwork6.id, body: "Mary comment on Ann Art3")

puts "Loading Likes..."
Like.destroy_all 
#Jake's Liked Artworks 
like1 = Like.create(user_id: user1.id, likeable_id: artwork4.id, likeable_type: Artwork)
like2 = Like.create(user_id: user1.id, likeable_id: artwork5.id, likeable_type: Artwork)
like3 = Like.create(user_id: user1.id, likeable_id: artwork6.id, likeable_type: Artwork)
like4 = Like.create(user_id: user1.id, likeable_id: artwork7.id, likeable_type: Artwork)
like5 = Like.create(user_id: user1.id, likeable_id: artwork8.id, likeable_type: Artwork)
like6 = Like.create(user_id: user1.id, likeable_id: artwork9.id, likeable_type: Artwork)
#Jake's Liked Comments
like7 = Like.create(user_id: user1.id, likeable_id: comment7.id, likeable_type: Comment)
like8 = Like.create(user_id: user1.id, likeable_id: comment8.id, likeable_type: Comment)
like9 = Like.create(user_id: user1.id, likeable_id: comment9.id, likeable_type: Comment)
like10 = Like.create(user_id: user1.id, likeable_id: comment13.id, likeable_type: Comment)
like11 = Like.create(user_id: user1.id, likeable_id: comment14.id, likeable_type: Comment)
like12 = Like.create(user_id: user1.id, likeable_id: comment15.id, likeable_type: Comment)
#Ann's Liked Artworks 
like13 = Like.create(user_id: user2.id, likeable_id: artwork1.id, likeable_type: Artwork)
like14 = Like.create(user_id: user2.id, likeable_id: artwork2.id, likeable_type: Artwork)
like15 = Like.create(user_id: user2.id, likeable_id: artwork3.id, likeable_type: Artwork)
like16 = Like.create(user_id: user2.id, likeable_id: artwork7.id, likeable_type: Artwork)
like17 = Like.create(user_id: user2.id, likeable_id: artwork8.id, likeable_type: Artwork)
like18 = Like.create(user_id: user2.id, likeable_id: artwork9.id, likeable_type: Artwork)
#Ann's Liked Comments 
like19 = Like.create(user_id: user2.id, likeable_id: comment1.id, likeable_type: Comment)
like20 = Like.create(user_id: user2.id, likeable_id: comment2.id, likeable_type: Comment)
like21 = Like.create(user_id: user2.id, likeable_id: comment3.id, likeable_type: Comment)
like22 = Like.create(user_id: user2.id, likeable_id: comment16.id, likeable_type: Comment)
like23 = Like.create(user_id: user2.id, likeable_id: comment17.id, likeable_type: Comment)
like24 = Like.create(user_id: user2.id, likeable_id: comment18.id, likeable_type: Comment)
#Mary's Liked Artworks 
like25 = Like.create(user_id: user3.id, likeable_id: artwork1.id, likeable_type: Artwork)
like26 = Like.create(user_id: user3.id, likeable_id: artwork2.id, likeable_type: Artwork)
like27 = Like.create(user_id: user3.id, likeable_id: artwork3.id, likeable_type: Artwork)
like28 = Like.create(user_id: user3.id, likeable_id: artwork4.id, likeable_type: Artwork)
like29 = Like.create(user_id: user3.id, likeable_id: artwork5.id, likeable_type: Artwork)
like30 = Like.create(user_id: user3.id, likeable_id: artwork6.id, likeable_type: Artwork)
#Mary's Liked Comments 
like31 = Like.create(user_id: user3.id, likeable_id: comment4.id, likeable_type: Comment)
like32 = Like.create(user_id: user3.id, likeable_id: comment5.id, likeable_type: Comment)
like33 = Like.create(user_id: user3.id, likeable_id: comment6.id, likeable_type: Comment)
like34 = Like.create(user_id: user3.id, likeable_id: comment10.id, likeable_type: Comment)
like35 = Like.create(user_id: user3.id, likeable_id: comment11.id, likeable_type: Comment)
like36 = Like.create(user_id: user3.id, likeable_id: comment12.id, likeable_type: Comment)

# puts "Loading Collections..."
Collection.destroy_all
#Jake's Collection of Jake's Art 
# collection1 = Collection.create(user_id: user1.id, artwork_id: artwork1.id, name: "Jake's Art")
# collection2 = Collection.create(user_id: user1.id, artwork_id: artwork2.id, name: "Jake's Art")
# collection3 = Collection.create(user_id: user1.id, artwork_id: artwork3.id, name: "Jake's Art")
#Jake's Collection of All Art 
# collection4 = Collection.create(user_id: user1.id, artwork_id: artwork1.id, name: "Jake's Collection All Art")
# collection5 = Collection.create(user_id: user1.id, artwork_id: artwork2.id, name: "Jake's Collection All Art")
# collection6 = Collection.create(user_id: user1.id, artwork_id: artwork3.id, name: "Jake's Collection All Art")
# collection7 = Collection.create(user_id: user1.id, artwork_id: artwork4.id, name: "Jake's Collection All Art")
# collection8 = Collection.create(user_id: user1.id, artwork_id: artwork5.id, name: "Jake's Collection All Art")
# collection9 = Collection.create(user_id: user1.id, artwork_id: artwork6.id, name: "Jake's Collection All Art")
# collection10 = Collection.create(user_id: user1.id, artwork_id: artwork7.id, name: "Jake's Collection All Art")
# collection11 = Collection.create(user_id: user1.id, artwork_id: artwork8.id, name: "Jake's Collection All Art")
# collection12 = Collection.create(user_id: user1.id, artwork_id: artwork9.id, name: "Jake's Collection All Art")
#Ann's Collection of Ann's Art 
# collection13 = Collection.create(user_id: user2.id, artwork_id: artwork4.id, name: "Ann's Art")
# collection14 = Collection.create(user_id: user2.id, artwork_id: artwork5.id, name: "Ann's Art")
# collection15 = Collection.create(user_id: user2.id, artwork_id: artwork6.id, name: "Ann's Art")
#Ann's Collection of All Art 
# collection16 = Collection.create(user_id: user2.id, artwork_id: artwork1.id, name: "Ann's Collection All Art")
# collection17 = Collection.create(user_id: user2.id, artwork_id: artwork2.id, name: "Ann's Collection All Art")
# collection18 = Collection.create(user_id: user2.id, artwork_id: artwork3.id, name: "Ann's Collection All Art")
# collection19 = Collection.create(user_id: user2.id, artwork_id: artwork4.id, name: "Ann's Collection All Art")
# collection20 = Collection.create(user_id: user2.id, artwork_id: artwork5.id, name: "Ann's Collection All Art")
# collection21 = Collection.create(user_id: user2.id, artwork_id: artwork6.id, name: "Ann's Collection All Art")
# collection22 = Collection.create(user_id: user2.id, artwork_id: artwork7.id, name: "Ann's Collection All Art")
# collection23 = Collection.create(user_id: user2.id, artwork_id: artwork8.id, name: "Ann's Collection All Art")
# collection24 = Collection.create(user_id: user2.id, artwork_id: artwork9.id, name: "Ann's Collection All Art")
#Mary's Collection of Mary's Art 
# collection25 = Collection.create(user_id: user3.id, artwork_id: artwork7.id, name: "Mary's Art")
# collection26 = Collection.create(user_id: user3.id, artwork_id: artwork8.id, name: "Mary's Art")
# collection27 = Collection.create(user_id: user3.id, artwork_id: artwork9.id, name: "Mary's Art")
#Mary's Collection of All Art 
# collection28 = Collection.create(user_id: user3.id, artwork_id: artwork1.id, name: "Mary's Collection All Art")
# collection29 = Collection.create(user_id: user3.id, artwork_id: artwork2.id, name: "Mary's Collection All Art")
# collection30 = Collection.create(user_id: user3.id, artwork_id: artwork3.id, name: "Mary's Collection All Art")
# collection31 = Collection.create(user_id: user3.id, artwork_id: artwork4.id, name: "Mary's Collection All Art")
# collection32 = Collection.create(user_id: user3.id, artwork_id: artwork5.id, name: "Mary's Collection All Art")
# collection33 = Collection.create(user_id: user3.id, artwork_id: artwork6.id, name: "Mary's Collection All Art")
# collection34 = Collection.create(user_id: user3.id, artwork_id: artwork7.id, name: "Mary's Collection All Art")
# collection35 = Collection.create(user_id: user3.id, artwork_id: artwork8.id, name: "Mary's Collection All Art")
# collection36 = Collection.create(user_id: user3.id, artwork_id: artwork9.id, name: "Mary's Collection All Art")