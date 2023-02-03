# == Schema Information
#
# Table name: superheroes
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  power           :integer          not null
#  secret_identity :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Superhero < ApplicationRecord 
    validates :name, :power, :secret_identity, presence: true
end 
