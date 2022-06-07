require 'byebug'

def chop_add(num1, num2)
    num1 = num1 / 5.0 
    num2 = num2 / 5.0
    
    # puts "Num1 & Num2 after dividing by 5.0"
    # puts num1 
    # puts num2 

    300.times do 
        num1 = num1 / 2 
        num2 = num2 / 2 
    end 

    # puts "\nNum1 & Num2 after dividing by 2 300 times"
    # puts num1 
    # puts num2 

    sum = num1 + num2 

    # puts "\nSum after adding num1 to num2"
    # puts sum 

    300.times { sum = sum * 2 }

    # puts "\nSum after multiplying sum by itself 300 times"
    # puts sum 

    # puts "Sum times 5"
    # puts sum * 5 

    sum * 5 
end 

puts "chop_add"
p chop_add(1, 1) == 2.0 
p chop_add(10, 1) == 11.0 
p chop_add(1, -5) == -4.0 


#num1 must be a positive integer or 0 
def iter_add(num1, num2)
    num1.times { num2 += 1 }
    num2 
end 

puts "\niter_add"
p iter_add(1, 1) == 2.0 
p iter_add(10, 1) == 11.0 
p iter_add(1, -5) == -4.0 



def linear_search(arr, val)
    arr.each_with_index { |el, i| return i if el == val}
    -1 
end 


#method xor's the byte representation of a number into a number twice in order to return the byte representation of the other number. xoring a byte representation of a number into the byte representation of another number twice cancels out the original number. 
def x_or(byte_rep1, byte_rep2)
    byte_rep_answer = []  

    0.upto(3).each do |idx| 
       if byte_rep1[idx] ^ byte_rep2[idx] == 1 
            byte_rep_answer << 1 
       else 
            byte_rep_answer << 0 
       end 
    end 

    byte_rep_answer
end 

#method returns the corresponding number of a byte representation
def find_missing_element(byte_rep, byte_reps)
    byte_reps.each { |num, byte_representation| return num if byte_representation == byte_rep } 
end 

#method returns the element in the first array that is missing in the second array. Solved to have a space O(1)....meaning the space taken up by the algorithm is constant regardless of input size. 
def missing_element(arr1, arr2)
    byte_reps = { 
        1 => [0, 0, 0, 1], 
        2 => [0, 0, 1, 0], 
        3 => [0, 0, 1, 1], 
        4 => [0, 1, 0, 0], 
        5 => [0, 1, 0, 1], 
        6 => [0, 1, 1, 0], 
        7 => [0, 1, 1, 1], 
        8 => [1, 0, 0, 0], 
        9 => [1, 0, 0, 1]
    }

    byte_rep = byte_reps[arr1[0]] 

    1.upto(arr1.length - 1).each { |i| byte_rep = x_or(byte_rep, byte_reps[arr1[i]]) } 
    0.upto(arr2.length - 1).each { |i| byte_rep = x_or(byte_rep, byte_reps[arr2[i]]) }

    find_missing_element(byte_rep, byte_reps)
end 

puts "\nMissing Element"
p missing_element([2, 7, 3, 2, 8], [2, 2, 8, 3])



			





