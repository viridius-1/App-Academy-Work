# == Schema Information
#
# Table name: users
#
#  id         :integer(8)      not null, primary key
#  email      :string          not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  premium    :boolean         default("false")
#


class User < ApplicationRecord 
    validates :email, presence: true, uniqueness: true 

    has_many :submitted_urls, 
        primary_key: :id, 
        foreign_key: :user_id, #shortened_urls table  
        class_name: :ShortenedUrl

    has_many :visits, 
        primary_key: :id,
        foreign_key: :user_id, 
        class_name: :Visit 

    has_many :visited_urls, 
        -> { distinct },
        through: :visits, 
        source: :shortened_url
end 



