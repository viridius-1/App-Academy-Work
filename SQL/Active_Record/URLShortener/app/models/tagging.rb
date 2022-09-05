# == Schema Information
#
# Table name: taggings
#
#  id               :integer(8)      not null, primary key
#  user_id          :integer(4)      not null
#  tag_topic_id     :integer(4)      not null
#  shortened_url_id :integer(4)      not null


class Tagging < ApplicationRecord 
    belongs_to :tag_topic, 
        primary_key: :id, 
        foreign_key: :tag_topic_id, #taggings table
        class_name: :TagTopic

    belongs_to :shortened_url, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #taggings table 
        class_name: :ShortenedUrl
end 

