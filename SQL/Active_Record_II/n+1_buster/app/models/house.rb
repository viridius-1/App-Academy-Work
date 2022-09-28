# == Schema Information
#
# Table name: houses
#
#  id         :integer(8)      not null, primary key
#  address    :string
#  created_at :datetime        not null
#  updated_at :datetime        not null

class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id, #gardeners table 
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  #creates an array of all the seeds within a given house. solves n + 1 problem.
  def better_seeds_query
    seeds = []
    plants_in_house = plants.includes(:seeds)
    plants_in_house.each { |plant| seeds << plant.seeds }
    seeds 
  end
end


