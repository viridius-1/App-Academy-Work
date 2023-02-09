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

puts "Loading Posts..."
Post.destroy_all 
#Jake's Posts 
post1 = Post.create(user_id: user1.id, title: "Post1 Title", body: "Post1 Body")
post2 = Post.create(user_id: user1.id, title: "Post2 Title", body: "Post2 Body")
post3 = Post.create(user_id: user1.id, title: "Post3 Title", body: "Post3 Body")
#Ann's Posts
post4 = Post.create(user_id: user2.id, title: "Post4 Title", body: "Post4 Body")
post5 = Post.create(user_id: user2.id, title: "Post5 Title", body: "Post5 Body")
post6 = Post.create(user_id: user2.id, title: "Post6 Title", body: "Post6 Body")
#Mary's Posts
post7 = Post.create(user_id: user3.id, title: "Post7 Title", body: "Post7 Body")
post8 = Post.create(user_id: user3.id, title: "Post8 Title", body: "Post8 Body")
post9 = Post.create(user_id: user3.id, title: "Post9 Title", body: "Post9 Body")

puts "Loading Comments..."
Comment.destroy_all 
#Jake's Comments 
comment1 = Comment.create(author_id: user1.id, post_id: post4.id, title: "Comment on Post4 Title", body: "Comment on Post4 Body")
comment2 = Comment.create(author_id: user1.id, post_id: post5.id, title: "Comment on Post5 Title", body: "Comment on Post5 Body")
comment3 = Comment.create(author_id: user1.id, post_id: post6.id, title: "Comment on Post6 Title", body: "Comment on Post6 Body")
comment4 = Comment.create(author_id: user1.id, post_id: post7.id, title: "Comment on Post7 Title", body: "Comment on Post7 Body")
comment5 = Comment.create(author_id: user1.id, post_id: post8.id, title: "Comment on Post8 Title", body: "Comment on Post8 Body")
comment6 = Comment.create(author_id: user1.id, post_id: post9.id, title: "Comment on Post9 Title", body: "Comment on Post9 Body")
#Ann's Comments
comment7 = Comment.create(author_id: user2.id, post_id: post1.id, title: "Comment on Post1 Title", body: "Comment on Post1 Body")
comment8 = Comment.create(author_id: user2.id, post_id: post2.id, title: "Comment on Post2 Title", body: "Comment on Post2 Body")
comment9 = Comment.create(author_id: user2.id, post_id: post3.id, title: "Comment on Post3 Title", body: "Comment on Post3 Body")
comment10 = Comment.create(author_id: user2.id, post_id: post7.id, title: "Comment on Post7 Title", body: "Comment on Post7 Body")
comment11 = Comment.create(author_id: user2.id, post_id: post8.id, title: "Comment on Post8 Title", body: "Comment on Post8 Body")
comment12 = Comment.create(author_id: user2.id, post_id: post9.id, title: "Comment on Post9 Title", body: "Comment on Post9 Body")
#Mary's Comments
comment13 = Comment.create(author_id: user3.id, post_id: post1.id, title: "Comment on Post1 Title", body: "Comment on Post1 Body")
comment14 = Comment.create(author_id: user3.id, post_id: post2.id, title: "Comment on Post2 Title", body: "Comment on Post2 Body")
comment15 = Comment.create(author_id: user3.id, post_id: post3.id, title: "Comment on Post3 Title", body: "Comment on Post3 Body")
comment16 = Comment.create(author_id: user3.id, post_id: post4.id, title: "Comment on Post4 Title", body: "Comment on Post4 Body")
comment17 = Comment.create(author_id: user3.id, post_id: post5.id, title: "Comment on Post5 Title", body: "Comment on Post5 Body")
comment18 = Comment.create(author_id: user3.id, post_id: post6.id, title: "Comment on Post6 Title", body: "Comment on Post6 Body")

puts "Loading Likes..."
Like.destroy_all
#Jake's Likes 
like1 = Like.create(user_id: user1.id, post_id: post4.id)
like2 = Like.create(user_id: user1.id, post_id: post5.id)
like3 = Like.create(user_id: user1.id, post_id: post6.id)
like4 = Like.create(user_id: user1.id, post_id: post7.id)
like5 = Like.create(user_id: user1.id, post_id: post8.id)
like6 = Like.create(user_id: user1.id, post_id: post9.id)
#Ann's Likes 
like7 = Like.create(user_id: user2.id, post_id: post1.id)
like8 = Like.create(user_id: user2.id, post_id: post2.id)
like9 = Like.create(user_id: user2.id, post_id: post3.id)
like10 = Like.create(user_id: user2.id, post_id: post7.id)
like11 = Like.create(user_id: user2.id, post_id: post8.id)
like12 = Like.create(user_id: user2.id, post_id: post9.id)
#Mary's Likes
like13 = Like.create(user_id: user3.id, post_id: post1.id)
like14 = Like.create(user_id: user3.id, post_id: post2.id)
like15 = Like.create(user_id: user3.id, post_id: post3.id)
like16 = Like.create(user_id: user3.id, post_id: post4.id)
like17 = Like.create(user_id: user3.id, post_id: post5.id)
like18 = Like.create(user_id: user3.id, post_id: post6.id)