# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  random_code :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

require 'securerandom'

class User < ApplicationRecord 
    validates :name, :random_code, presence: true 
    before_validation :ensure_random_code 

    protected 

    def ensure_random_code
        self.random_code ||= SecureRandom.hex(8)
    end 
end 



