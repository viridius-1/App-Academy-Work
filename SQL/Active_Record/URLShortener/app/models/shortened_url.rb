# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer(8)      not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null


require 'securerandom'

class ShortenedUrl < ApplicationRecord 
    validates :long_url, :user_id, presence: true 
    validates :short_url, uniqueness: true 
    
    #Write custom validations to: 
        #prevent users from submitting more than 5 urls in 1 minute...this is the custom validation method #no_spamming. provide an informative error message if the validation fails. 
        #limit the number of total urls non-premium users can submit to 5...this is the custom validation method #nonpremium_max. you have to add a "premium" boolean column to your Users table. if a boolean isnt given the column should default to false. 

    #factory method 
    def self.shorten_url(user, long_url) 
        ShortenedUrl.create!(
            long_url: long_url, 
            short_url: self.random_code, 
            user_id: user.id 
        )
    end 

    def self.random_code 
        good_code = false 

        while !good_code
            short_url_string = SecureRandom.urlsafe_base64(16)
            good_code = true unless ShortenedUrl.exists?(short_url: short_url_string)
        end 

        short_url_string
    end 

    belongs_to :submitter, 
        primary_key: :id,  
        foreign_key: :user_id, #shortened_urls table  
        class_name: :User 

    has_many :visits, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #visits table  
        class_name: :Visit 

    has_many :visitors, 
        -> { distinct },
        through: :visits, 
        source: :visitor  

    has_many :taggings, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #taggings table  
        class_name: :Tagging 

    has_many :tag_topics, 
        -> { distinct },
        through: :taggings,
        source: :tag_topic  

    def num_clicks
        visits.length 
    end 

    def num_uniques
        visitors.length 
    end 

    def num_recent_uniques
        Visit.select(:user_id).distinct.where(created_at: 10.minutes.ago..Time.current).length 
    end 
end 

