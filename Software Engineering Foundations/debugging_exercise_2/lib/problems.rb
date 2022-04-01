# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require 'byebug'

#method that returns the largest prime factor of a number 
def largest_prime_factor(n)

    #get factors 
    factors = get_factors(n)

    #sort factors in decreasing order 
    factors.sort!.reverse! 

    #iterate through factors and return first prime 
    factors.each { |factor| return factor if is_prime?(factor) } 
end 

#method that returns the factors of a number 
def get_factors(n)
    factors = []
    (1..n).each { |i|  factors << i if n % i == 0 } 
    factors 
end 

#method that returns a boolean indicating whether a number is prime 
def is_prime?(n)

    return false if n < 2 

    (2...n).each { |i| return false if n % i == 0 } 

    true 
end 

#method that returns a boolean. true means there are no duplicate characters in string. false means there are duplicate characters in string 
def unique_chars?(string)

    idx1 = 0 
    while idx1 < string.length - 1 

        char1 = string[idx1]
        idx2 = idx1 + 1 
        while idx2 < string.length 
            char2 = string[idx2] 
            return false if char1 == char2
            idx2 += 1 
        end 

        idx1 += 1 
    end 

    true 
end 

#method that takes in array. returns a hash with keys that were repeating elements in the array and the indices where they occurred.
def dupe_indices(arr)

  answer = Hash.new { |h, k| h[k] = [] }

  arr.each_with_index { |ltr, idx| answer[ltr] << idx }

  answer.select { |ltr, indices| indices.length > 1 }
end 

#method that takes in 2 arrays. returns boolean indicating whether the arrays contain the same elements, in any order
def ana_array(arr1, arr2)
    sorted_arr1 = alpha_sort(arr1)
    sorted_arr2 = alpha_sort(arr2)
    sorted_arr1 == sorted_arr2
end 

#method that sorts an array alphabetically 
def alpha_sort(arr)

  sorted = false 

  while !sorted 
    sorted = true 
    idx = 0 
    while idx < arr.length - 1 
      char1 = arr[idx][0]
      char2 = arr[idx + 1][0]
      el1 = arr[idx]
      el2 = arr[idx + 1] 
        if char1 > char2 
          arr[idx + 1] = el1
          arr[idx] = el2
          sorted = false 
        end 
      idx += 1 
    end 
  end 

  arr 
end 









