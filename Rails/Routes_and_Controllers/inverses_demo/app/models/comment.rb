# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  author_id  :integer          not null
#  post_id    :integer          not null
#  title      :string           not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Comment < ApplicationRecord
    validates :author_id, :post_id, :title, :body, presence: true 

    belongs_to :author, 
        class_name: :User
end 
