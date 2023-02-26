# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          default(0)
#  post_id    :integer          default(0)

class Like < ApplicationRecord 
    belongs_to :user, 
        inverse_of: :likes 

    belongs_to :post, 
        inverse_of: :likes 
end 
