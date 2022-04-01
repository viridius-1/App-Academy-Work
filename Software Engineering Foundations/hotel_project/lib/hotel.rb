require "byebug"
require_relative "room"

class Hotel 
    
    def initialize(name, hash)
        @name = name 
        
        #fill @rooms hash 
        @rooms = {}
        hash.each { |room, capacity| @rooms[room] = Room.new(capacity) } 
    end 

    #capitalizes name 
    def name 
        (@name.split.map! { |word| word.capitalize }).join(' ') 
    end 

    def rooms 
        @rooms 
    end 

    def room_exists?(room)  
        @rooms.keys.include?(room)
    end 

    def check_in(name, room)
        if room_exists?(room)
            if @rooms[room].add_occupant(name)
                puts "check in successful"
            else 
                puts "sorry, room is full"
            end 
        else 
            puts "sorry, room does not exist"
        end 
    end 

    def has_vacancy? 
        @rooms.each_key { |room| return true if !@rooms[room].full? } 
        false      
    end 

    def list_rooms 
        @rooms.each_key do |room| 
            avail_space = @rooms[room].available_space 
            puts "#{room} #{avail_space}"
        end 
    end 

end 
