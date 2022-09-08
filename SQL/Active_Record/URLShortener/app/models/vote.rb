# == Schema Information
#
# Table name: votes
#
#  id               :integer(8)      not null, primary key
#  user_id          :integer(4)      not null
#  shortened_url_id :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Vote < ApplicationRecord 
    validates :user_id, :shortened_url_id, presence: true 
    validate :no_own_url_voting, :no_double_url_voting

    #factory method
    def self.cast_vote(user, shortened_url)
        Vote.create!(
            user_id: user.id, 
            shortened_url_id: shortened_url.id 
        )
    end 

    belongs_to :voter, 
        primary_key: :id,  
        foreign_key: :user_id, #votes table 
        class_name: :User 

    belongs_to :shortened_url, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #votes table 
        class_name: :ShortenedUrl

    def no_own_url_voting 
        if shortened_url.user_id == user_id 
            errors[:user_id] << "can't vote for own url."
        end 
    end 

    def no_double_url_voting 
        if Vote.exists?(user_id: user_id, shortened_url_id: shortened_url_id)
            errors[:user_id] << "can't vote for a url more than once."
        end 
    end 
end 

