require_relative 'stack_queue'
require_relative 'my_stack'
require 'byebug'

arr = [0, 1, 5, 7]

def time(start_time)
    Time.now - start_time
end 

def print_time(start_time)
    puts "Finished in #{time(start_time)} seconds."
    puts "---------------------------------------"
end 

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
start_time = Time.now 
p bad_two_sum?(arr, 6) == true 
#p bad_two_sum?(arr, 10)
print_time(start_time)



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
start_time = Time.now 
p okay_two_sum?(arr, 6) == true 
# p bad_two_sum?(arr, 10)
print_time(start_time)


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
start_time = Time.now 
p hash_map_two_sum?(arr, 6) == true 
# p bad_two_sum?(arr, 10)
print_time(start_time)


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
start_time = Time.now 
# p four_sum_v1?(arr, 30)
# p four_sum_v1?(arr, 19)
# p four_sum_v1?(arr, 18)
p four_sum_v1?(arr, 16)
# p four_sum_v1?(arr, 14)
# p four_sum_v1?(arr, 12)
# p four_sum_v1?(arr, 7) 
# p four_sum_v1?(arr, 2) 
print_time(start_time)



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
start_time = Time.now 
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v2?([0, 1, 5, 7, 2, 8, 3, 9], 2)
print_time(start_time)


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
start_time = Time.now 
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v3?([0, 1, 5, 7, 2, 8, 3, 9], 2)
print_time(start_time)


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
start_time = Time.now 
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 30)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 19)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 18)
p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 16)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 14)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 12)
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 7) 
# p four_sum_v4?([0, 1, 5, 7, 2, 8, 3, 9], 2)
print_time(start_time)