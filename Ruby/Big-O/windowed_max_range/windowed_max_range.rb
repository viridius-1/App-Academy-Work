require_relative 'min_max_stack_queue'

def time(start_time)
    Time.now - start_time
end 

def print_time(start_time)
    puts "Finished in #{time(start_time)} seconds."
    puts "---------------------------------------"
end 

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

start_time = Time.now 
puts "Windowed Max Range V1"
p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
print_time(start_time)


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

start_time = Time.now 
puts "Windowed Max Range V2"
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range_v2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
print_time(start_time)




