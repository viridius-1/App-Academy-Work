# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          default(0), not null

class Like < ApplicationRecord 
    validates :user_id, :post_id, presence: true 

    belongs_to :user, 
        inverse_of: :likes 

    belongs_to :post, 
        inverse_of: :likes 
end 
