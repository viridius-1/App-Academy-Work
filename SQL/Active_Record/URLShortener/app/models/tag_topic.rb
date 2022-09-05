# == Schema Information
#
# Table name: tag_topics
#
#  id        :integer(8)      not null, primary key
#  tag_topic :string          not null


class TagTopic < ApplicationRecord
    has_many :taggings, 
        primary_key: :id,
        foreign_key: :tag_topic_id, #taggings table 
        class_name: :Tagging
    
    has_many :shortened_urls, 
        through: :taggings, 
        source: :shortened_url
    
    def popular_links
        visited_links = {}
        top_5_visited_links = {}

        shortened_urls.each { |shortened_url| visited_links[shortened_url] = shortened_url.num_clicks }  
        visited_link_arr = visited_links.sort_by { |shortened_url, clicks| clicks }.reverse[0..4]
        visited_link_arr.each { |visited_link| top_5_visited_links[visited_link.first] = visited_link.last }

        top_5_visited_links.each do |visited_link, clicks| 
            puts "VISITED LINK"
            p visited_link
            puts "CLICKS - #{clicks}\n\n"
        end 
    end 
end 

