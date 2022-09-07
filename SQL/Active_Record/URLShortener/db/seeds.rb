# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all 
user1 = User.create!(email: "jshap83@icloud.com", premium: true)
user2 = User.create!(email: "george@yahoo.com")
user3 = User.create!(email: "ann@yahoo.com")

ShortenedUrl.destroy_all
#user1's urls 
url1 = ShortenedUrl.shorten_url(user1, "https://www.cnn.com/2022/09/04/us/elkhorn-coral-spawn-florida-aquarium-climate/index.html")
url2 = ShortenedUrl.shorten_url(user1, "https://www.foxnews.com/lifestyle/this-labor-day-grateful-nod-long-haul-truckers-keep-america-moving")
url3 = ShortenedUrl.shorten_url(user1, "https://www.pbs.org/video/september-4-2022-pbs-news-weekend-full-episode-1662305362/")
url4 = ShortenedUrl.shorten_url(user1, "https://www.nba.com/watch/video/how-does-trading-for-donovan-mitchell-improve-the-cavs-title-chances")
url5 = ShortenedUrl.shorten_url(user1, "https://www.bet.com/episodes/kxbzx7/haus-of-vicious-vicious-lies-season-1-ep-3")
#user2's urls
url6 = ShortenedUrl.shorten_url(user2, "https://www.cnn.com/2022/09/04/us/elkhorn-coral-spawn-florida-aquarium-climate/index.html")
url7 = ShortenedUrl.shorten_url(user2, "https://www.foxnews.com/lifestyle/this-labor-day-grateful-nod-long-haul-truckers-keep-america-moving")
url8 = ShortenedUrl.shorten_url(user2, "https://www.pbs.org/video/september-4-2022-pbs-news-weekend-full-episode-1662305362/")
url9 = ShortenedUrl.shorten_url(user2, "https://www.nba.com/watch/video/how-does-trading-for-donovan-mitchell-improve-the-cavs-title-chances")
url10 = ShortenedUrl.shorten_url(user2, "https://www.bet.com/episodes/kxbzx7/haus-of-vicious-vicious-lies-season-1-ep-3")
#user3's urls
url11 = ShortenedUrl.shorten_url(user3, "https://www.cnn.com/2022/09/04/us/elkhorn-coral-spawn-florida-aquarium-climate/index.html")
url12 = ShortenedUrl.shorten_url(user3, "https://www.foxnews.com/lifestyle/this-labor-day-grateful-nod-long-haul-truckers-keep-america-moving")
url13 = ShortenedUrl.shorten_url(user3, "https://www.pbs.org/video/september-4-2022-pbs-news-weekend-full-episode-1662305362/")
url14 = ShortenedUrl.shorten_url(user3, "https://www.nba.com/watch/video/how-does-trading-for-donovan-mitchell-improve-the-cavs-title-chances")
url15 = ShortenedUrl.shorten_url(user3, "https://www.bet.com/episodes/kxbzx7/haus-of-vicious-vicious-lies-season-1-ep-3")


Visit.destroy_all 
#user1's visits 
7.times { Visit.record_visit!(user1, url1) } 
Visit.record_visit!(user1, url2)
Visit.record_visit!(user1, url3)
3.times { Visit.record_visit!(user1, url4) } 
#user2's visits
Visit.record_visit!(user2, url6)
5.times { Visit.record_visit!(user2, url7) }
Visit.record_visit!(user2, url8)
Visit.record_visit!(user2, url9)
#user3's visits
Visit.record_visit!(user3, url11)
4.times { Visit.record_visit!(user3, url12) } 
Visit.record_visit!(user3, url13)
Visit.record_visit!(user3, url14)


TagTopic.destroy_all 
tag1 = TagTopic.create!(tag_topic: "News")
tag2 = TagTopic.create!(tag_topic: "Conservative")
tag3 = TagTopic.create!(tag_topic: "Liberal")
tag4 = TagTopic.create!(tag_topic: "Public")
tag5 = TagTopic.create!(tag_topic: "Sports")
tag6 = TagTopic.create!(tag_topic: "Music")

Tagging.destroy_all 
#user1's taggings 
Tagging.create!(user_id: 1, tag_topic_id: tag1.id, shortened_url_id: url1.id)
Tagging.create!(user_id: 1, tag_topic_id: tag3.id, shortened_url_id: url1.id)
Tagging.create!(user_id: 1, tag_topic_id: tag1.id, shortened_url_id: url2.id)
Tagging.create!(user_id: 1, tag_topic_id: tag2.id, shortened_url_id: url2.id)
Tagging.create!(user_id: 1, tag_topic_id: tag1.id, shortened_url_id: url3.id)
Tagging.create!(user_id: 1, tag_topic_id: tag4.id, shortened_url_id: url3.id)
Tagging.create!(user_id: 1, tag_topic_id: tag2.id, shortened_url_id: url3.id)
Tagging.create!(user_id: 1, tag_topic_id: tag3.id, shortened_url_id: url3.id)
Tagging.create!(user_id: 1, tag_topic_id: tag5.id, shortened_url_id: url4.id)
Tagging.create!(user_id: 1, tag_topic_id: tag6.id, shortened_url_id: url5.id)
#user2's taggings 
Tagging.create!(user_id: 2, tag_topic_id: tag1.id, shortened_url_id: url6.id)
Tagging.create!(user_id: 2, tag_topic_id: tag3.id, shortened_url_id: url6.id)
Tagging.create!(user_id: 2, tag_topic_id: tag1.id, shortened_url_id: url7.id)
Tagging.create!(user_id: 2, tag_topic_id: tag2.id, shortened_url_id: url7.id)
Tagging.create!(user_id: 2, tag_topic_id: tag1.id, shortened_url_id: url8.id)
Tagging.create!(user_id: 2, tag_topic_id: tag4.id, shortened_url_id: url8.id)
Tagging.create!(user_id: 2, tag_topic_id: tag2.id, shortened_url_id: url8.id)
Tagging.create!(user_id: 2, tag_topic_id: tag3.id, shortened_url_id: url8.id)
Tagging.create!(user_id: 2, tag_topic_id: tag5.id, shortened_url_id: url9.id)
Tagging.create!(user_id: 2, tag_topic_id: tag6.id, shortened_url_id: url10.id)
#user3's taggings 
Tagging.create!(user_id: 3, tag_topic_id: tag1.id, shortened_url_id: url11.id)
Tagging.create!(user_id: 3, tag_topic_id: tag3.id, shortened_url_id: url11.id)
Tagging.create!(user_id: 3, tag_topic_id: tag1.id, shortened_url_id: url12.id)
Tagging.create!(user_id: 3, tag_topic_id: tag2.id, shortened_url_id: url12.id)
Tagging.create!(user_id: 3, tag_topic_id: tag1.id, shortened_url_id: url13.id)
Tagging.create!(user_id: 3, tag_topic_id: tag4.id, shortened_url_id: url13.id)
Tagging.create!(user_id: 3, tag_topic_id: tag2.id, shortened_url_id: url13.id)
Tagging.create!(user_id: 3, tag_topic_id: tag3.id, shortened_url_id: url13.id)
Tagging.create!(user_id: 3, tag_topic_id: tag5.id, shortened_url_id: url14.id)
Tagging.create!(user_id: 3, tag_topic_id: tag6.id, shortened_url_id: url15.id)
