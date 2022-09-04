# == Schema Information
#
# Table name: visits
#
#  id               :integer(8)      not null, primary key
#  user_id          :integer(4)      not null
#  shortened_url_id :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null


class Visit < ApplicationRecord 
    validates :user_id, :shortened_url_id, presence: true 

    belongs_to :visitor, 
        primary_key: :id, 
        foreign_key: :user_id, #visits table 
        class_name: :User 

    belongs_to :shortened_url, 
        primary_key: :id, 
        foreign_key: :shortened_url_id, #visits table  
        class_name: :ShortenedUrl

    #factory method 
    def self.record_visit!(user, shortened_url)
        Visit.create!(
            user_id: user.id, 
            shortened_url_id: shortened_url.id 
        )
    end 
end 

