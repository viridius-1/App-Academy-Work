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

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
    SELECT DISTINCT 
      continent
    FROM 
      countries 
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL)
    SELECT 
      SUM(gdp)
    FROM 
      countries 
    WHERE 
      continent = 'Africa' 
  SQL
end

def area_count
  # How many countries have an area of more than 1,000,000?
  execute(<<-SQL)
    SELECT 
      COUNT(name)
    FROM 
      countries 
    WHERE 
      area > 1000000
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
    SELECT 
      SUM(population)
    FROM 
      countries 
    WHERE 
      name IN ('France', 'Germany', 'Spain')  
  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
    SELECT DISTINCT
      continent, COUNT(continent) AS Countries
    FROM 
      countries 
    GROUP BY 
      continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
    SELECT DISTINCT 
      continent, COUNT(continent) AS Countries_over_10_million_people
    FROM 
      countries
    WHERE 
      population >= 10000000
    GROUP BY 
      continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
    SELECT 
      continent 
    FROM 
      countries 
    GROUP BY 
      continent
    HAVING 
      SUM(population) >= 100000000
  SQL
end


#CONTINENTS
puts "CONTINENTS"
p continents
puts "-------------------------------------"

#AFRICA GDP
puts "AFRICA GDP"
p africa_gdp
puts "-------------------------------------"

#AREA COUNT
puts "AREA COUNT"
p area_count
puts "-------------------------------------"

#GROUP POPULATION
puts "GROUP POPULATION"
p group_population
puts "-------------------------------------"

#COUNTRY COUNTS 
puts "COUNTRY COUNTS"
p country_counts
puts "-------------------------------------"

#POPULOUS COUNTRY COUNTS 
puts "POPULOUS COUNTRY COUNTS"
p populous_country_counts
puts "-------------------------------------"

#POPULOUS CONTINENTS 
puts "POPULOUS CONTINENTS"
p populous_continents
puts "-------------------------------------"