list = [0, 3, 5, 4, -5, 10, 1, 90]

def time(start_time)
    Time.now - start_time
end 

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
start_time = Time.now 
p my_min_phase1(list) == -5
puts "Finished in #{time(start_time)} seconds."
puts "-------------------------"


#method finds the smallest number in a list. iterates through list to find smallest number. 
#Uses O(n) time and O(1) space. 
def my_min_phase2(my_list)
    smallest_num = nil 
    my_list.each { |num| smallest_num = num if smallest_num == nil || num < smallest_num  }
    smallest_num
end 

puts "my_min Phase II"
list = [0, 3, 5, 4, -5, 10, 1, 90]
start_time = Time.now 
p my_min_phase2(list) == -5 
puts "Finished in #{time(start_time)} seconds."
puts "-------------------------"



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
start_time = Time.now 
p largest_contiguous_subsum_phase1(list1) == 8 
# p largest_contiguous_subsum_phase1(list2) == 8
# p largest_contiguous_subsum_phase1(list3) == -1 
puts "Finished in #{time(start_time)} seconds."
puts "-------------------------"


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
start_time = Time.now 
p largest_contiguous_subsum_phase2(list1) == 8 
# p largest_contiguous_subsum_phase2(list2) == 8
# p largest_contiguous_subsum_phase2(list3) == -1 
puts "Finished in #{time(start_time)} seconds."
puts "-------------------------"


