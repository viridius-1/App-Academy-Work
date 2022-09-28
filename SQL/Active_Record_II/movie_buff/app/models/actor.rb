# == Schema Information
#
# Table name: actors
#
#  id   :integer(8)      not null, primary key
#  name :string          not null

class Actor < ApplicationRecord
  has_many :castings,
    class_name: :Casting,
    foreign_key: :actor_id, #castings table
    primary_key: :id

  has_many :movies,
    through: :castings,
    source: :movie

  has_many :directed_movies,
    class_name: :Movie,
    foreign_key: :director_id, #movies table 
    primary_key: :id
end


