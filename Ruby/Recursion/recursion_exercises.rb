require "byebug"

#method returns an array of all numbers in range. solves recursively. ex: a start of 1 and end of 5 returns [1, 2, 3, 4]
def range(start_num, end_num)
    return [] if start_num == end_num or end_num < start_num 
    [start_num] + range(start_num + 1, end_num)
end 

#method sums an array iteratively 
def sum_arr_iteratively(arr)
    sum = 0 
    arr.each { |i| sum += i}
    sum 
end 

#method sums an array recursively 
def sum_arr_recursively(arr)
    return arr[0] if arr.length == 1 
    arr[0] + sum_arr_recursively(arr[1..-1]) 
end 

#method raises a base, b, to an exponent, n, recursively. version 1.  
def exp_v1(b, n)
    return 1 if n == 0 
    b * exp_v1(b, n - 1)
end 

#method raises a base to an exponent recursively. version 2. 
def exp_v2(base, exponent)
    return 1 if exponent == 0 
    return base if exponent == 1 

    exponent_divided_by_2 = exponent / 2 
    exponent_minus_1_divided_by_2 = (exponent - 1) / 2 

    if exponent.even?  
        base_to_exponent_divided_by_2 = exp_v2(base, exponent_divided_by_2)       
        base_to_exponent_divided_by_2 * base_to_exponent_divided_by_2
    else 
        base_to_exponent_minus1_divided_by_2 = exp_v2(base, exponent_minus_1_divided_by_2)     
        base * base_to_exponent_minus1_divided_by_2 * base_to_exponent_minus1_divided_by_2 
    end 
end 

#method makes a deep copy of an array 
def deep_dup(el)
    return el if !el.is_a?(Array)

    arr = []
    el.each do |arr_el|  
        if arr_el.is_a?(Array)
            arr << arr_el.dup 
        else 
            arr << deep_dup(arr_el)     
        end 
    end 
    arr 
end 

#method returns the first n numbers of the fibonacci sequence. solves iteratively.  
def fibs_iterative(n)
    fib_seq = [0, 1] 
    if n == 0 
        [] 
    elsif n == 1 
        [0]
    elsif n == 2 
        [0, 1]
    else 
        until fib_seq.length == n 
            fib_seq << fib_seq[-1] + fib_seq[-2] 
        end 
        fib_seq 
    end 
end 

#method returns the first n numbers of the fibonacci sequence. solves recursively. 
def fibs_recursive(n)
    return [] if n == 0 
    return [0] if n == 1 
    return [0, 1] if n == 2 
    fibs_recursive(n - 1) << fibs_recursive(n - 1)[-2..-1].sum 
end 

#method takes in a sorted array and a target value. does a recursive binary search. returns idx that target value is at. returns nil if target is not in array.  
def bsearch(arr, target) 
    return nil if arr.empty? 

    arr_middle_idx = arr.length / 2  
    arr_middle_value = arr[arr_middle_idx]

    if target == arr_middle_value
        return arr_middle_idx 
    elsif target < arr_middle_value 
        bsearch(arr[0...arr_middle_idx], target)
    elsif target > arr_middle_idx 
        sub_answer = bsearch(arr[arr_middle_idx + 1..-1], target)
        sub_answer.nil? ? nil : (arr_middle_idx + 1) + sub_answer
    end 
end 

#Test Cases 
puts "Binary Search"
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3) # => 2
p bsearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 15) # => 14
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
puts "-------------------------------\n"

#method takes in a sorted array and a target value. does a two pointer search. returns idx that target value is at. returns nil if target is not in array. 
def psearch(arr, target)
    pointer1 = 0 
    pointer2 = arr.length - 1 

    until pointer1 > pointer2 
        if arr[pointer1] == target
            return pointer1 
        elsif arr[pointer2] == target 
            return pointer2 
        else 
            pointer1 += 1 
            pointer2 -= 1 
        end 
    end 

    nil 
end 

#Test Cases 
puts "Two Pointer Search"
p psearch([1, 2, 3], 1) # => 0
p psearch([2, 3, 4, 5], 3) # => 1
p psearch([2, 4, 6, 8, 10], 6) # => 2
p psearch([1, 3, 4, 5, 9], 5) # => 3
p psearch([1, 2, 3, 4, 5, 6], 6) # => 5
p psearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3) # => 2
p psearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 15) # => 14
p psearch([1, 2, 3, 4, 5, 6], 0) # => nil
p psearch([1, 2, 3, 4, 5, 7], 6) # => nil
puts "-------------------------------\n"

#method recursively sorts an array using merge sort 
def merge_sort(arr) 
  return arr if arr.length <= 1

  half_of_arr = arr.length / 2 
  left = arr.take(half_of_arr)
  right = arr.drop(half_of_arr)

  left_half, right_half = merge_sort(left), merge_sort(right) 

  merge(left_half, right_half)
end 

#helper method for merge_sort. merges and sorts arrays. 
def merge(left_half, right_half)
  merged_arr = []

  until left_half.empty? || right_half.empty? 
    if left_half.first < right_half.first 
      merged_arr << left_half.shift 
    else 
      merged_arr << right_half.shift 
    end 
  end 

  merged_arr + left_half + right_half 
end 

puts "Merge Sort"
p merge_sort([5, 1, 9, 3, 0, 8, 2]) 
p merge_sort([9, 4, 10, 3, 1]) 
puts "-------------------------------\n"

class Array 
    #method returns the subsets of an array. solves recursively. 
    def subsets
        return [[]] if empty? 
        subarrays = take(length - 1).subsets 
        subarrays.concat(subarrays.map { |sub_arr| sub_arr + [last] }) 
    end 
end 

puts "Array Subsets"
p [].subsets
p [1].subsets
p [1, 2].subsets
p [1, 2, 3].subsets
p [1, 2, 3, 4].subsets
puts "-------------------------------\n"

#method returns the permutations of an array. solves recursively. 
def permutations(arr)
  return [arr] if arr.length <= 1 

  first = arr.shift 
  perms = permutations(arr) 

  total_permutations = []

  perms.each do |perm| 
    (0..perm.length).each do |i| 
      total_permutations << perm[0...i] + [first] + perm[i..-1]
    end 
  end 

  total_permutations
end 

puts "Permutations"
p permutations([])
p permutations([1])
p permutations([1, 2])
p permutations([1, 2, 3])
puts "-------------------------------\n"

#method does a greedy make change. takes in change and array of coins. returns coins of largest amount and fewest quantity. solves recursively. 
def greedy_make_change(change, coins=[10, 7, 1]) 
  #return no change if change is less than smallest coin 
  return [] if change < coins.min || change.is_a?(Float)

  #return coin if change is exactly equal to a coin 
  coins.each { |coin| return [coin] if coin == change } 
  
  #take as many of the biggest coins as possible and add them to the result 
  result = []
  coins.each do |coin| 
    qty_of_coins_to_add = (change - result.sum) / coin 
    qty_of_coins_to_add.times { result << coin }
  end 

  change_remaining = change - result.sum 
  coins_remaining = coins.select { |coin| coin <= change_remaining }

  if result.sum == change 
    return result 
  else 
    return result + greedy_make_change(change_remaining, coins_remaining)
  end 
end 

puts "Greedy Make Change"
p greedy_make_change(14)
p greedy_make_change(24)
p greedy_make_change(17)
p greedy_make_change(9)
p greedy_make_change(27)
p greedy_make_change(92)
puts "-------------------------------\n"

#method takes in change and array of coins. returns fewest qty of coins that make the change. works for any number of coins. solves recursively. 
def make_better_change(change, coins)
    return [] if change == 0 
    best_change = nil 

    coins.each_with_index do |coin, idx| 
        next if coin > change 
        remainder = change - coin 
        rest_of_change = make_better_change(remainder, coins.drop(idx))   
        change_result = [coin] + rest_of_change
        best_change = change_result if best_change == nil || change_result.length < best_change.length 
    end 

    best_change
end 

puts "Make Better Change"
p make_better_change(14, [10, 7, 1])
p make_better_change(24, [10, 7, 1])
p make_better_change(17, [10, 7, 1])
p make_better_change(9, [10, 7, 1])
p make_better_change(27, [10, 7, 1])
p make_better_change(92, [10, 7, 1])
puts "-------------------------------\n"











