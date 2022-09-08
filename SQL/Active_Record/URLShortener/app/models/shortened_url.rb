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
    validate :no_spamming, :nonpremium_max
    
    #factory method 
    def self.shorten_url(user, long_url) 
        if user.premium 
            ShortenedUrl.create!(
                long_url: long_url, 
                short_url: Word.all.sample.word + Word.all.sample.word + Word.all.sample.word,
                user_id: user.id 
            )
        else 
            ShortenedUrl.create!(
                long_url: long_url, 
                short_url: self.random_code, 
                user_id: user.id 
            )
        end 
    end 

    def self.random_code 
        good_code = false 

        while !good_code
            short_url_string = SecureRandom.urlsafe_base64(16)
            good_code = true unless ShortenedUrl.exists?(short_url: short_url_string)
        end 

        short_url_string
    end 

    #deletes shortened urls that haven't been visited in last n minutes 
    def self.prune(n)
        #get visited urls older than n minutes and remove them from database 
        Visit.all.each do |visit| 
            next if !ShortenedUrl.exists?(visit.shortened_url_id) || visit.visitor.premium
            if visit.created_at < n.minutes.ago
                ShortenedUrl.find(visit.shortened_url_id).destroy
            end 
        end 
        
        #get urls that haven't been visited and remove them from database if they are older than n minutes 
        ShortenedUrl.all.each do |shortened_url| 
            if !Visit.exists?(shortened_url_id: shortened_url.id) && !shortened_url.submitter.premium
                shortened_url.destroy if shortened_url.created_at < n.minutes.ago 
            end 
        end 
    end 

    #returns shortened urls by by most votes to least votes 
    def self.top 
        shortened_urls = {}

        ShortenedUrl.all.each do |shortened_url| 
            if Vote.exists?(shortened_url_id: shortened_url.id)
                shortened_urls[shortened_url] = Vote.where(shortened_url_id: shortened_url.id).length 
            end 
        end 

        sort_urls_by_vote(shortened_urls)
    end 

    #returns shortened urls with votes in last n minutes. ordered from most votes to least votes. 
    def self.hot(n)
        recently_voted_urls = {}
        range = n.minutes.ago..Time.current 

        ShortenedUrl.top.each do |shortened_url_data| 
            votes_of_shortened_url = Vote.where(shortened_url_id: shortened_url_data.first.id)
            votes_of_shortened_url.each do |vote| 
                if range.include?(vote.created_at)
                    recently_voted_urls[shortened_url_data.first] = shortened_url_data.last  
                    break 
                end 
            end 
        end 

        sort_urls_by_vote(recently_voted_urls)
    end 

    def self.sort_urls_by_vote(urls)
        urls.sort_by { |shortened_url, votes| votes }.reverse 
    end 

    belongs_to :submitter, 
        primary_key: :id,  
        foreign_key: :user_id, #shortened_urls table  
        class_name: :User 

    has_many :visits, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #visits table  
        class_name: :Visit, 
        dependent: :destroy 

    has_many :visitors, 
        -> { distinct },
        through: :visits, 
        source: :visitor  

    has_many :taggings, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #taggings table  
        class_name: :Tagging, 
        dependent: :destroy

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

    private 

    def no_spamming
        if ShortenedUrl.where(created_at: 1.minute.ago..Time.current, user_id: user_id).length == 5 
            errors[:message] << "Can't create more than 5 urls per minute."
        end 
    end 

    def nonpremium_max 
        if ShortenedUrl.where(user_id: user_id).length >= 5
            errors[:message] << "Can't submit more than 5 urls for non-premium users."
        end 
    end 
end 