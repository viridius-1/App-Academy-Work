# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  author      :string           not null
#  year        :integer
#  category    :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

class Book < ApplicationRecord
    validates :title, :author, presence: true 
end 
