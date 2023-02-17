# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  user_id       :integer          not null
#  likeable_type :string           not null
#  likeable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null

class Like < ApplicationRecord
    validates :likeable_id, :likeable_type, presence: true 

    belongs_to :likeable, polymorphic: true 

    belongs_to :liker, 
        primary_key: :id, 
        foreign_key: :user_id, #likes table
        class_name: :User
end 
