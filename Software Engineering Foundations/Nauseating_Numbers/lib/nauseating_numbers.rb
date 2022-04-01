#method that returns the number of pairs of elements that sum to 0 in an array 
def strange_sums(arr)
    pairs = 0 

    idx1 = 0 
    while idx1 < arr.length - 1 
        num1 = arr[idx1]

        idx2 = idx1 + 1 
        while idx2 < arr.length 
            num2 = arr[idx2]
            pairs += 1 if num1 + num2 == 0 
            idx2 += 1 
        end 

        idx1 += 1 
    end 

    pairs 
end 

puts "\nStrange Sums"
p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0
puts "-----------------------------\n\n"


#method returns a boolean of whether a pair of elements in an array can produce a product 
def pair_product(arr, product)
   
    idx1 = 0 
    while idx1 < arr.length - 1 
        num1 = arr[idx1]

        idx2 = idx1 + 1 
        while idx2 < arr.length 
            num2 = arr[idx2]
            return true if num1 * num2 == product 
            idx2 += 1 
        end 

        idx1 += 1 
    end 

    false 
end 

puts "\nPair Products" 
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false
puts "-----------------------------\n\n"


#method takes in string and hash. returns new string with each letter repeated the number of times specified in the hash. 
def rampant_repeats(string, hash)
    new_str = ''
    string.each_char do |char| 
        if hash.has_key?(char)
            new_str += char * hash[char] 
        else 
            new_str += char 
        end 
    end 
    new_str 
end 

puts "\nRampant Repeats"
p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'
puts "-----------------------------\n\n"


#method returns a boolean if a number is a perfect square 
def perfect_square(num)
    i = 1 

    while true 
        return true if i * i == num 
        return false if i * i > num 
        i += 1 
    end 
end 

puts "\nPerfect Square"
p perfect_square(1)     # true
p perfect_square(4)     # true
p perfect_square(64)    # true
p perfect_square(100)   # true
p perfect_square(169)   # true
p perfect_square(2)     # false
p perfect_square(40)    # false
p perfect_square(32)    # false
p perfect_square(50)    # false
puts "-----------------------------\n\n"


#method returns true if a number is an anti-prime. an anti-prime has more divisors than any number less than it. 
def anti_prime?(n)
    n_divisors = divisors(n) 
    (1...n).each { |i| return false if divisors(i) > n_divisors } 
    true 
end 

#method returns the number of divisors of a number 
def divisors(n)
    divisors = 0 
    (1..n).each { |i| divisors += 1 if n % i == 0 }
    divisors 
end 

puts "\nAnti Prime"
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false
puts "-----------------------------\n\n"


#method that adds matrices together
def matrix_addition(mat1, mat2)
    new_matrix = []

    arr_idx = 0 
    while arr_idx < mat1.length 

        num_idx = 0 
        sub_arr = []
        while num_idx < mat1[arr_idx].length 
            sub_arr << mat1[arr_idx][num_idx] + mat2[arr_idx][num_idx]
            num_idx += 1 
        end 
        
        new_matrix << sub_arr 
        arr_idx += 1 
    end 

    new_matrix 
end 

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

puts "\nMatrix Addition"
p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]
puts "-----------------------------\n\n"


#method accepts any number of numbers as arguments. method that returns the mutual factors among the arguments. 
def mutual_factors(*nums)
    mutuals = []
    hash = Hash.new { |hash, key| hash[key] = [] }   

    nums.each do |num| 
        (1..num).each { |i| hash[i] << num if num % i == 0 }
    end 

    hash.each { |k, v| mutuals << k if v.length == nums.length }

    mutuals 
end 

puts "\nMututal Factors"
p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]
puts "-----------------------------\n\n"


#method returns the n-th tribonacci number
def tribonacci_number(n)
    tribs = [1, 1, 2]

    if n == 1 || n == 2 
        1 
    elsif n == 3 
        2 
    else 
        until tribs.length == n 
            tribs << tribs[-1] + tribs[-2] + tribs[-3] 
        end 
        tribs[-1]
    end 
end 

puts "\nTribonacci Number"
p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274
puts "-----------------------------\n\n"



#methods accepts any number of matrices and adds them together. returns nil if matrices have different dimensions. 
def matrix_addition_reloaded(*matrices)

        if same_dimensions?(matrices)
            new_matrix = []

            arr_idx = 0
            while arr_idx < matrices[0].length 
                
                num_idx = 0 
                sub_arr = []
                while num_idx < matrices[0][0].length 
                    num = 0 
                    matrices.each { |matrix| num += matrix[arr_idx][num_idx] } 
                    sub_arr << num 
                    num_idx += 1 
                end 

                new_matrix << sub_arr 
                arr_idx += 1 
            end 
        else 
           return nil 
        end 

    new_matrix 
end 

#method returns boolean of whether matrices are the same dimensions 
def same_dimensions?(matrices)

    idx = 0 
    while idx < matrices.length - 1 
        current_mat = matrices[idx] 
        next_mat = matrices[idx + 1]
        return false if current_mat.length != next_mat.length 
        idx += 1 
    end 

    true 
end 


matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

puts "\nMatrix Addition Reloaded"
p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil
puts "-----------------------------\n\n"



#method takes in 2D array. returns boolean indicating whether any row or column is completely filled with the same elements. 
def squarocol?(arr)

    #check rows 
    arr.each do |row| 
        return true if row.all? { |el| el == row[0] } 
    end 

    #check columns 
    el_idx = 0 
    while el_idx < arr[0].length 

        col_arr = []
        arr_idx = 0 
        while arr_idx < arr.length 
            col_arr << arr[arr_idx][el_idx]
            arr_idx += 1 
        end 

        return true if col_arr.all? { |el| el == col_arr[0] }
        el_idx += 1 
    end 

    false 
end 



puts "\nSquarocol?"
p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false
puts "-----------------------------\n\n"


#method takes in 2D array. returns boolean indicating whether the same element occurs across a diagonal section. 
def squaragonal?(arr)

    #check left to right diagonal
    ltor_diag = []
    ltor_idx = 0 
    while ltor_idx < arr.length 
        ltor_diag << arr[ltor_idx][ltor_idx]
        ltor_idx += 1 
    end 
    return true if ltor_diag.all? { |el| el == ltor_diag[0] }

    #check right to left diagonal 
    rtol_diag = []
    el_idx = arr.length - 1 
    col_idx = 0 
    while col_idx < arr.length 
        rtol_diag << arr[col_idx][el_idx]
        el_idx -= 1 
        col_idx += 1 
    end 
    return true if rtol_diag.all? { |el| el == rtol_diag[0] }

    false 
end 

puts "\nSquaragonal?"
p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false
puts "-----------------------------\n\n"


#method returns the first n levels of Pascals Triangle 
def pascals_triangle(n)
    pascals = [[1]] 

    until pascals.length == n 
        if pascals[-1].length > 1 
            pascals << next_level(pascals[-1]) 
        else 
            pascals << [1, 1]
        end 
    end 

    pascals 
end 

#method generates next level of pascals triangle 
def next_level(level)
    next_lvl = [1]

    idx = 0 
    while idx < level.length - 1
        next_lvl << level[idx] + level[idx + 1]
        idx += 1 
    end 
    next_lvl << 1 

    next_lvl 
end 


puts "\nPascals Triangle"
p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]
puts "-----------------------------\n\n"


#method returns the n-th mersenne prime 
def mersenne_prime(n)
    mersennes = []

    i = 2 
    until mersennes.length == n 
        mersennes << i if candidate?(i) && prime?(i) 
        i += 1 
    end 

    mersennes[-1] 
end 

#method returns boolean of whether a number is a mersenne prime candidate 
def candidate?(num)
    pwr = 1 

    while true 
        ans = (2 ** pwr) - 1 
        if ans > num 
            return false 
        elsif ans == num 
            return true 
        end 
        pwr += 1 
    end 
end 

#method returns boolean of whether a number is prime 
def prime?(num)
    (2...num).each { |i| return false if num % i == 0}
    true 
end 

puts "\nMersenne Prime"
p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071
puts "-----------------------------\n\n"


#method returns boolean indicating whether a word's number encoding is a triangular number 
def triangular_word?(word)
    num = 0 
    word.each_byte { |ascii_num| num += ascii_num % 96 }

    i = 1
    while true 
        ans = (i * (i + 1)) / 2 
        if ans > num 
            return false 
        elsif ans == num 
            return true 
        else    
            i += 1 
        end 
    end 
end 

puts "\nTriangular Word"
p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false
puts "-----------------------------\n\n"


#method that does a consecutive collapse and returns a new array 
def consecutive_collapse(arr)
    collapsed = false 

    while !collapsed 
        if arr_collapsed?(arr) 
            collapsed = true 
        else 
            arr = do_collapse(arr)
        end 
    end 

    arr 
end 

#method returns boolean of whether an array is collapsed 
def arr_collapsed?(arr)
    idx = 0 
    while idx < arr.length - 1 
        return false if arr[idx] - arr[idx + 1] == 1 || arr[idx] - arr[idx + 1] == -1
        idx += 1 
    end 
    true 
end 

#method does a collapse by removing adjacent pairs and returning the new array 
def do_collapse(arr)
    idx = 0 
    while idx < arr.length - 1 
        if arr[idx] - arr[idx + 1] == 1 || arr[idx] - arr[idx + 1] == -1
            2.times { arr.delete_at(idx) } 
            return arr 
        end 
        idx += 1 
    end 
end 

puts "\nConsecutive Collapse"
p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []
puts "-----------------------------\n\n"


#method takes in array and number. returns new array. each element is replaced with next prime in direction of number.
def pretentious_primes(arr, num)
    new_arr = []
    arr.each { |el| new_arr << get_el(el, num) } 
    new_arr 
end 

#method returns the next appropriate element 
def get_el(el, num) 
    prime_ct = 0 

    if num > 0 
        until prime_ct == num 
            el += 1 
            prime_ct += 1 if prime?(el) 
        end 
    elsif num < 0 
        until prime_ct == num * -1 
            el -= 1 
            return nil if el < 2 
            prime_ct += 1 if prime?(el) 
        end 
    end 

    el 
end 

#method returns a boolean of whether a number is prime
def prime?(num)
    (2...num).each { |i| return false if num % i == 0 }
    true 
end 


puts "\nPretentious Primes"
p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]
puts "-----------------------------\n\n"