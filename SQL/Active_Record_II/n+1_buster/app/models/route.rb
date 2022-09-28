# == Schema Information
#
# Table name: routes
#
#  id         :integer(8)      not null, primary key
#  number     :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id, #buses table 
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  #method returns an array of drivers of a single bus 
  def get_drivers_of_single_bus(bus)
    drivers_of_single_bus = []
    bus.drivers.each { |driver| drivers_of_single_bus << driver.name }
    drivers_of_single_bus
  end 

  #creates hash with bus id's as keys and an array of bus drivers as the corresponding value. solves n + 1 problem. 
  def better_drivers_query
    all_drivers = {}
    buses_that_drive_route = buses.includes(:drivers)   
    
    buses_that_drive_route.each do |bus| 
      drivers_of_single_bus = get_drivers_of_single_bus(bus)
      all_drivers[bus.id] = drivers_of_single_bus
    end 

    all_drivers 
  end
end



