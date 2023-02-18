# == Schema Information
#
# Table name: collections
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Collection < ApplicationRecord
    validates :user_id, :artwork_id, :name, presence: true 

    belongs_to :collector, 
        primary_key: :id, 
        foreign_key: :user_id, #collections table
        class_name: :User
end 
