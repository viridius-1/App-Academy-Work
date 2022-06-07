require_relative 'stack_queue'
require_relative 'my_stack'
require_relative 'min_max_stack_queue'
require 'benchmark'

def benchmark(method)
    Benchmark.benchmark(Benchmark::CAPTION, 0, Benchmark::FORMAT) { }
    puts Benchmark.measure { method }  
    print_end
end 

def print_end 
    puts "------------------------------------------"
end 


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
benchmark(sluggish_octopus(fish_array))


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
answer = dominant_octopus(fish_array) 
p answer[-1] == "fiiiissshhhhhh"
benchmark(dominant_octopus(fish_array))


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
benchmark(clever_octopus(fish_array)) 


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
benchmark(slow_dance("right-down", tiles_array))


#method accesses the tentacle number the octopus must move in O(1) time.  
def fast_dance(direction, tiles_hash) 
    tiles_hash[direction]
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
p answer > 3
benchmark(fast_dance("right-down", tiles_hash))



#Execution Time Difference

#method finds the smallest number in a list. compares each element to every other element. returns element if all other elements in array are larger. 
#Uses O(n^2) time and O(n^2) space. 
def my_min_phase1(my_list)
    my_list.each do |el1| 
        element = my_list.delete(el1)
        return el1 if my_list.all? { |el| el1 < el }
        my_list.unshift(element)
    end 
end 

puts "my_min Phase I"
list = [0, 3, 5, 4, -5, 10, 1, 90]
p my_min_phase1(list) == -5
benchmark(my_min_phase1(list))

#method finds the smallest number in a list. iterates through list to find smallest number. 
#Uses O(n) time and O(1) space. 
def my_min_phase2(my_list)
    smallest_num = nil 
    my_list.each { |num| smallest_num = num if smallest_num == nil || num < smallest_num  }
    smallest_num
end 

puts "my_min Phase II"
list = [0, 3, 5, 4, -5, 10, 1, 90]
p my_min_phase2(list) == -5 
benchmark(my_min_phase2(list))


# Largest Contiguous Sub-sum
list1 = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [-5, -1, -3]

#method returns all sub-arays of an array 
def get_sub_arrays(array)
    sub_arrays = []
    0.upto(array.length - 1).each do |idx1| 
        idx1.upto(array.length - 1).each do |idx2| 
            sub_arrays << array[idx1..idx2]
        end 
    end 
    sub_arrays
end 

#iterates through array & finds all sub-arrays. holds all sub-arrays in 1 array. finds sums of each sub-array and returns the max. 
#Uses O(n^3) time and O(n^3) space 
def largest_contiguous_subsum_phase1(my_list)
    max = nil 
    sub_arrays = get_sub_arrays(my_list)
    sub_arrays.each { |sub_array| max = sub_array.sum if max == nil || sub_array.sum > max } 
    max 
end 

puts "largest_contiguous_subsum Phase I"
p largest_contiguous_subsum_phase1(list1) == 8 
# p largest_contiguous_subsum_phase1(list2) == 8
# p largest_contiguous_subsum_phase1(list3) == -1 
benchmark(largest_contiguous_subsum_phase1(list1))

#takes in an array. returns the sum of the sub-array within the array with the largest sum. 
#uses O(n) time and O(1) memory
def largest_contiguous_subsum_phase2(my_list)
    largest = my_list.first 
    current = my_list.first 

    (1...my_list.length).each do |i| 
        current = 0 if current < 0 
        current += my_list[i] 
        largest = current if current > largest 
    end 

    largest
end 

puts "largest_contiguous_subsum Phase II"
p largest_contiguous_subsum_phase2(list1) == 8 
# p largest_contiguous_subsum_phase2(list2) == 8
# p largest_contiguous_subsum_phase2(list3) == -1 
benchmark(largest_contiguous_subsum_phase2(list1))


#Anagrams

#method returns all anagrams of a string 
def get_anagrams(string)
    combos = string.split('').permutation(string.length).to_a 
    combos.map! { |combo| combo.join }
end 

#method generates all possible anagrams of first string. returns boolean whether 2nd string is one of those anagrams.
#Time O(n^2) 
#Space O(n^2)  
def first_anagram?(str1, str2)
    anagrams = get_anagrams(str1)
    anagrams.include?(str2)
end 

puts "Anagrams Phase I"
p first_anagram?('cats', 'tacs')
benchmark(first_anagram?('cats', 'tacs'))

#method returns boolean of whether str2 is anagram of str1. does this by iterating over each character of str1 and finding that character in str2 and deleting it.....then checking to see if str2 is empty at the end of the iteration of str1
#Time O(n)
#Space O(n)
def second_anagram?(str1, str2)
    str2_arr = str2.split('')

    str1.each_char do |char| 
        index_of_char_in_str2 = str2_arr.index(char)
        str2_arr.delete_at(index_of_char_in_str2)
    end 

    str2_arr.empty? 
end 

puts "Anagrams Phase II"
p second_anagram?('cats', 'tacs')
benchmark(second_anagram?('cats', 'tacs'))

#method returns boolean of whether str2 is anagram of str1. does this by sorting both strings alphabetically. 
#Time O(n log n)
#Space O(n)
def third_anagram?(str1, str2)
    str1.split('').sort.join == str2.split('').sort.join
end 

puts "Anagrams Phase III"
p third_anagram?('cats', 'tacs')
benchmark(third_anagram?('cats', 'tacs'))

#method returns boolean of whether str2 is anagram of str1. does this by creating hashes to store the number of times the letters appear in both words.....and then comparing the hashes
#Time O(n)
#Space O(1)
def fourth_anagram_phase1(str1, str2)
    str1_hash = Hash.new(0)
    str2_hash = Hash.new(0) 

    str1.each_char { |char| str1_hash[char] += 1 }
    str2.each_char { |char| str2_hash[char] += 1 }

    str1_hash == str2_hash 
end 

puts "Anagrams Phase IV Part I"
p fourth_anagram_phase1('cats', 'tacs')
benchmark(fourth_anagram_phase1('cats', 'tacs'))

#method returns boolean of whether str2 is anagram of str1. does this by using 1 hash. 
#Time O(n)
#Space O(1)
def fourth_anagram_phase2(str1, str2)
    str_hash = Hash.new(0)

    #load hash w/ character count based on str1 
    str1.each_char { |char| str_hash[char] += 1 } 

    #evaluate if str2 is anagram of str1 based on str_hash 
    str2.each_char do |char| 
        occurences_of_char_in_str2 = str2.count(char)
        return false if str_hash[char] != occurences_of_char_in_str2 
    end 
    
    true 
end 

puts "Anagrams Phase IV Part II"
p fourth_anagram_phase2('cats', 'tacs')
benchmark(fourth_anagram_phase2('cats', 'tacs'))


#Two Sum Problem 
arr = [0, 1, 5, 7]

#method returns boolean of whether 2 numbers in array sum to target. uses a double nested array iteration to solve. this is a brute force method.  
#Time - O(n^2)
#Space - O(1) 
def bad_two_sum?(arr, target)
    0.upto(arr.length - 1).each do |idx1| 
        0.upto(arr.length - 1).each do |idx2|
            if idx1 != idx2 
                return true if arr[idx1] + arr[idx2] == target 
            end 
        end 
    end 

    false 
end 

puts "Bad Two Sum"
p bad_two_sum?(arr, 6) == true 
#p bad_two_sum?(arr, 10)
benchmark(bad_two_sum?(arr, 6))


def two_sum?(arr, target)
    arr.each { |num| return true if arr.include?(target - num) } 
    false 
end 

#method returns boolean of whether 2 numbers in array sum to target. solves by using sorting.
#Time - O(n log n)
#Space - O(n)
def okay_two_sum?(arr, target)
    arr.sort! 
    if arr[0] == 0 && arr.include?(target) 
        return true 
    else 
        arr.select! { |num| num < target }
        two_sum?(arr, target)
    end 
end 

puts "Okay Two Sum"
p okay_two_sum?(arr, 6) == true 
# p bad_two_sum?(arr, 10)
benchmark(okay_two_sum?(arr, 6))

#method returns boolean of whether 2 numbers in array sum to target. solves using a hash map. 
#Time - O(n)
#Space - O(n)
def hash_map_two_sum?(arr, target)
    num_hash = {}
    arr.each do |num|
        if num_hash.has_key?(target - num) 
            return true 
        else 
            num_hash[num] = 1 
        end 
    end 
    false 
end 

puts "Two Sum"
p hash_map_two_sum?(arr, 6) == true 
# p bad_two_sum?(arr, 10)
benchmark(hash_map_two_sum?(arr, 6))

#method returns boolean of whether 4 numbers in array sum to target. uses combinations method to solve. 
#Time - O(n)
#Space - O(n)
def four_sum_v1?(arr, target)
    combos = arr.combination(4).to_a 
    combos.each { |combo| return ["true", combo, target] if combo.sum == target } 
    false 
end 

puts "Four Sum V1"
arr = [0, 1, 5, 7, 2, 8, 3, 9]
# p four_sum_v1?(arr, 30)
# p four_sum_v1?(arr, 19)
# p four_sum_v1?(arr, 18)
p four_sum_v1?(arr, 16)
# p four_sum_v1?(arr, 14)
# p four_sum_v1?(arr, 12)
# p four_sum_v1?(arr, 7) 
# p four_sum_v1?(arr, 2) 
benchmark(four_sum_v1?(arr, 16))

#method returns boolean of whether 4 numbers in array sum to target. uses manual combinations and a queue implemented with 2 stacks. 
#Time - O(n^4)
#Space - O(1)
def four_sum_v2?(arr, target)
    return false if arr.all? { |num| num > target }
    queue = StackQueue.new
   # arr.select! { |num| num <= target }

    #get combinations 
    0.upto(arr.length - 4).each do |idx1| 
        (idx1 + 1).upto(arr.length - 1) do |idx2| 
            (idx2 + 1).upto(arr.length - 1) do |idx3| 
                (idx3 + 1).upto(arr.length - 1) do |idx4| 
                    sum = 0 

                    queue.enqueue(arr[idx1])
                    queue.enqueue(arr[idx2])
                    queue.enqueue(arr[idx3])
                    queue.enqueue(arr[idx4])

                    4.times { sum += queue.dequeue } 

                    return [true, target] if sum == target 
                end 
            end 
        end 
    end 
   
    false 
end 

puts "Four Sum V2"
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 2)
benchmark(four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 16))

#method generates a hash where indices correspond to their array elements 
def fill_hash(arr)
    hash = {}
    arr.each_with_index { |num, idx| hash[idx] = num }
    hash 
end 

#method returns boolean of whether 4 numbers in array sum to target. uses a hash and a queue implemented with 2 stacks. 
#Time - O(n^4)
#Space - O(1)
def four_sum_v3?(arr, target)
    return false if arr.all? { |num| num > target }
    queue = StackQueue.new

    hash = fill_hash(arr)

    0.upto(4).each do |idx1| 
        (idx1 + 1).upto(7).each do |idx2| 
            (idx2 + 1).upto(7).each do |idx3| 
                (idx3 + 1).upto(7).each do |idx4| 
                    sum = 0 

                    queue.enqueue(hash[idx1])
                    queue.enqueue(hash[idx2])
                    queue.enqueue(hash[idx3])
                    queue.enqueue(hash[idx4])
              
                    4.times { sum += queue.dequeue } 

                    return [true, target] if sum == target 
                end 
            end 
        end 
    end 

    false 
end 

puts "Four Sum V3"
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 2)
benchmark(four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 16))

#method returns boolean of whether 4 numbers in array sum to target. uses 3 hashes.
#Time - O(n^2)
#Space - O(n^2) 
def four_sum_v4?(arr, target)
    hash = {}
    two_sum_hash = {}
    three_sum_hash = {}

    arr.each do |num| 
        return [true, target] if three_sum_hash[target - num]
        two_sum_hash.each_key { |key| three_sum_hash[key + num] = true }
        hash.each_key { |key| two_sum_hash[key + num] = true } 
        hash[num] = true 
    end 
  
    false 
end

puts "Four Sum V4"
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 2)
benchmark(four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 16))


#Windowed Max Range 

#method returns the largest range of a sub-array of the array, based on the window size. Time O(n^2), Space O(n)
#This version is costly b/c we have to calculate the max and min of the window. This works out to Time O(n^2). 
#We're also spending O(n) time every time we slice the array by creating a new window.
#We want a way to calculate the min and max instantaneously per window. That would let use find the max windowed range in O(n) time. 
def windowed_max_range(array, window_size)
    current_max_range = nil   
    
    0.upto(array.length - window_size).each do |idx| 
        window = array[idx...(idx + window_size)]
        range = window.max - window.min 
        current_max_range = range if current_max_range == nil || range > current_max_range 
    end 

    current_max_range
end 

puts "Windowed Max Range V1"
p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
benchmark(windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4)

#method calculates the max range of sub-arrays in an array based on the window size. Calculates in Time O(n), Space O(n). 
def windowed_max_range_v2(array, window_size)
    current_max_range = nil   
    
    idx1 = 0 
    while idx1 <= array.length - window_size
        queue = MinMaxStackQueue.new 

        #send first space to queue
        window_start = array[idx1]
        queue.enqueue(window_start)

        #send successive spaces to queue
        idx2 = idx1 + 1 
        (window_size - 1).times do 
            next_space = array[idx2]
            queue.enqueue(next_space)
            idx2 += 1 
        end 

        #calculate this window's range
        range = queue.max - queue.min 

        current_max_range = range if current_max_range == nil || range > current_max_range 
        idx1 += 1 
    end 

    current_max_range
end 

puts "Windowed Max Range V2"
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range_v2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
benchmark(windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4)