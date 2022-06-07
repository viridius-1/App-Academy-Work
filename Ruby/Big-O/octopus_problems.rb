#Big O-ctopus and Biggest Fish Questions
fish_array = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

#method finds the longest fish in O(n^2) time. Does this by comparing all fish lengths to all other fish lengths. 
def sluggish_octopus(arr)
    start_time = Time.now
    longest_fish = arr[0]

    0.upto(arr.length - 2) do |idx1| 
        (idx1 + 1).upto(arr.length - 1) { |idx2| longest_fish = arr[idx2] if arr[idx2].length > arr[idx1].length } 
    end 


    [longest_fish, Time.now - start_time] 
end 

puts "SLUGGISH OCTOPUS - O(n^2) time"
answer = sluggish_octopus(fish_array) 
p answer[0] == "fiiiissshhhhhh"
puts "Finished in #{answer[1]} seconds."
puts "------------------------------------------"


def merge(left_half, right_half)
    merged_array = []

    until left_half.empty? || right_half.empty? 
        if left_half[0].length < right_half[0].length
            merged_array << left_half.shift 
        else 
            merged_array << right_half.shift 
        end 
    end 

    merged_array + left_half + right_half
end 

#finds longest fish in O(n log n) time. Does this with merge sort. 
def dominant_octopus(arr)
    return arr if arr.length <= 1 

    half_of_array = arr.length / 2 
    left = arr.take(half_of_array)
    right = arr.drop(half_of_array)

    left_half, right_half = dominant_octopus(left), dominant_octopus(right)

    merge(left_half, right_half)
end 

puts "DOMINANT OCTOPUS - O(n log n) time"
start_time = Time.now 
answer = dominant_octopus(fish_array) 
p answer[-1] == "fiiiissshhhhhh"
puts "Finished in #{Time.now - start_time} seconds."
puts "------------------------------------------"


#method finds longest fish in O(n) time. Does this by stepping through the array once. 
def clever_octopus(arr)
    start_time = Time.now 
    longest_fish = nil 
    arr.each { |fish| longest_fish = fish if longest_fish == nil || fish.length > longest_fish.length }
    [longest_fish, Time.now - start_time]
end 

puts "CLEVER OCTOPUS - O(n) time"
answer = clever_octopus(fish_array) 
p answer[0] == "fiiiissshhhhhh"
puts "Finished in #{answer[1]} seconds."
puts "------------------------------------------"


#DANCING OCTOPUS QUESTIONS 
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

#method iterates through tiles array to return the tentacle number (tile index) the octopus must move. Takes O(n) time.
def slow_dance(direction, tiles)
    start_time = Time.now 
    tentacle = 1 
    tiles.each_with_index do |tile, idx|
        return [tentacle, Time.now - start_time] if direction == tile 
        tentacle += 1 
    end 
end 
puts "SLOW DANCE - O(n) time"
#p slow_dance("up", tiles_array) > 0 
answer = slow_dance("right-down", tiles_array) 
p answer[0] > 3 
puts "Finished in #{answer[1]} seconds."
puts "------------------------------------------"

#method accesses the tentacle number the octopus must move in O(1) time.  
def fast_dance(direction, tiles_hash)
    start_time = Time.now 
    [tiles_hash[direction], Time.now - start_time]
end 

tiles_hash = {
        "up" => 1, 
        "right-up" => 2, 
        "right" => 3,
        "right-down" => 4, 
        "down" => 5, 
        "left-down" => 6, 
        "left" => 7,  
        "left-up" => 8   
    }
puts "FAST DANCE - O(1) time"
# answer = fast_dance("up", tiles_hash)
# p answer[0] > 0
answer = fast_dance("right-down", tiles_hash)
p answer[0] > 3
puts "Finished in #{answer[1]} seconds."
puts "------------------------------------------"


