#method sums an array of integers. solves recursively. 
def sum(arr)
    return arr[0] if arr.length == 1 
    arr[0] + sum(arr[1..-1])
end 
puts "Problem 1"
p sum([1, 2, 3])
p sum([4, 5, 6])
puts"--------------------\n" 

#method returns a boolean of whether an array has a specific value. solves recursively. 
def has_el?(arr, value)
    if arr.length == 1 
        if arr[0] == value 
            return true 
        else 
            return false 
        end 
    end 
    has_el?(arr[0..0], value) || has_el?(arr[1..-1], value)
end 
puts "Problem 2"
p has_el?([1, 2, 3], 3)
p has_el?([4, 5, 6], 7)
p has_el?([4, 5, 6, 7, 8, 9, 10, 11, 12], 7)
puts"--------------------\n" 

#method that counts the number of occurences of an element in an array. solves recursively. 
def occurences(arr, el)
    if arr.length == 1 
        if arr[0] == el 
            return 1
        else 
            return 0 
        end 
    end 
    occurences(arr[0..0], el) + occurences(arr[1..-1], el)
end 
puts "Problem 3"
p occurences([3, 2, 2, 1, 2, 5, 4], 2)
p occurences([4, 2, 5, 1, 3], 2)
p occurences([5, 3, 4, 1], 2) 
puts"--------------------\n" 

#method returns a boolean of whether 2 adjacent elements of an array sum to 12. solves recursively. 
def adj_sum12?(arr)
    if arr.length == 2 
        if arr.sum == 12 
            return true 
        else 
            return false 
        end 
    end 
    adj_sum12?(arr[0..1]) || adj_sum12?(arr[1..-1])
end 
puts "Problem 4"
p adj_sum12?([1, 2, 4, 8, 5])           #true 
p adj_sum12?([1, 2, 3, 4, 5])           #false 
p adj_sum12?([1, 2, 3, 4, 5, 1, 11, 9]) #true 
p adj_sum12?([1, 2, 3])                 #false 
p adj_sum12?([1, 2, 10])                #true 
p adj_sum12?([0, 12])                   #true 
p adj_sum12?([1, 2])                    #false 
p adj_sum12?([1, 2, 11, 3])             #false 
p adj_sum12?([1, 2, 3, 11])             #false  
p adj_sum12?([1, 2, 3, 9])              #true 
puts"--------------------\n" 

#method returns a boolean of whether an array is sorted from smallest to greatest. solves recursively. 
def sorted?(arr)
    if arr.length == 1 
        return true 
    elsif arr.length == 2 
        if arr[0] <= arr[1] 
            return true 
        else 
            return false 
        end 
    end 
    sorted?(arr[0..1]) && sorted?(arr[1..-1])     
end 
puts "Problem 5"
p sorted?([1, 2, 3, 4, 5]) #true 
p sorted?([2, 1, 5, 3, 4]) #false 
p sorted?([5, 4, 3, 2, 1]) #false 
p sorted?([-5, -4, -3, -2, -1]) #true 
p sorted?([-1, -2, -3, -4, -5]) #false 
puts"--------------------\n" 

#reverses a string recursively 
def reverse(str)
    return str if str.length == 1 
    str[-1] + reverse(str[0...-1]) 
end 
puts "Problem 6"
p reverse("cat")
p reverse("cool")
p reverse("reverse")
puts"--------------------\n" 
