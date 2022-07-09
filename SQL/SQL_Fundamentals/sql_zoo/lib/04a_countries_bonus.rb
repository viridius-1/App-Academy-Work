# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT 
      name
    FROM 
      countries 
    WHERE 
      gdp > (
        SELECT 
          MAX(gdp)
        FROM 
          countries 
        WHERE 
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT 
      continent, name, area 
    FROM 
      countries 
    WHERE 
      area IN (
        SELECT 
          MAX(area)
        FROM 
          countries 
        GROUP BY 
          continent
      ) 
    ORDER BY 
      area DESC
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT 
      c1.name, c1.continent 
    FROM 
      countries AS c1 
    WHERE 
      population > 3 * (
        SELECT 
          MAX(c2.population)
        FROM 
          countries AS c2
        WHERE 
          c1.name != c2.name AND c1.continent = c2.continent
      )
    SQL
end

#HIGHEST GDP 
p highest_gdp
puts "--------------------------------"

#LARGEST IN CONTINENT 
p largest_in_continent
puts "--------------------------------"

#LARGE NEIGHBORS
p large_neighbors
puts "--------------------------------"
