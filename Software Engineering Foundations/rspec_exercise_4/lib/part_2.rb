#method returns the proper factors of a number 
def proper_factors(n)
    (1...n).to_a.select { |i| n % i == 0 }
end 

#method returns the sum of the proper factors of a number 
def aliquot_sum(n)
    proper_factors(n).sum 
end 

#method returns boolean of whether a number is equal to the sum of its proper factors 
def perfect_number?(n)
    aliquot_sum(n) == n 
end 

#method returns array of the first n perfect numbers 
def ideal_numbers(n)
    perf_nums = []

    i = 2 
    while perf_nums.length < n 
        perf_nums << i if perfect_number?(i)
        i += 1 
    end 
    
    perf_nums 
end 