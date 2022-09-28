# == Schema Information
#
# Table name: gardeners
#
#  id         :integer(8)      not null, primary key
#  name       :string          not null
#  house_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Gardener < ApplicationRecord
  belongs_to :house,
    class_name: 'House',
    foreign_key: :house_id, #gardeners table 
    primary_key: :id

  has_many :plants,
    class_name: 'Plant',
    foreign_key: :gardener_id, #plants table 
    primary_key: :id
end


