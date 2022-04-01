class Stack 

    attr_accessor :cat_food

    def initialize 
        @cat_food = []
    end 

    def push(food)
        cat_food << food 
    end 

    def pop 
        cat_food.pop 
    end 

    def peek 
        cat_food[-1]
    end 

end 


class Queue

    attr_accessor :people 

    def initialize 
        @people = []
    end 

    def enqueue(el)
        people << el 
    end 

    def dequeue 
        people.shift  
    end 

    def peek 
        people[0]
    end 

end 


class Map 

    attr_accessor :nfc_east_teams

    def initialize
        @nfc_east_teams = []
    end 

    def city_exists?(city)
        nfc_east_teams.any? { |team| team[0] == city } 
    end 

    def set(city, team_name)
        if city_exists?(city)
            nfc_east_teams.each { |team| team[1] = team_name if team[0] == city } 
        else 
            nfc_east_teams << [city, team_name]
        end 
    end 

    def get(city)
        nfc_east_teams.each { |team| return team[1] if team[0] == city } 
    end 

    def delete(city)
        nfc_east_teams.each_with_index { |team, idx| nfc_east_teams.delete_at(idx) if team[0] == city } 
    end 

    def show_nfc_east_teams
        nfc_east_teams
    end 

end 

