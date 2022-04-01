#method calculates the sum from 1 to n recursively 
def sum_to(n)
    return nil if n < 1 
    return 1 if n == 1 
    n + sum_to(n - 1)
end 

# Test Cases
puts "Exercise 1 - sum_to"
p sum_to(5)  # => returns 15
p sum_to(1)  # => returns 1
p sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil
puts "--------------------------\n"


#method calculates the sum of numbers in an array recursively 
def add_numbers(arr)
    return nil if arr.empty? 
    return arr[0] if arr.length == 1 
    arr[0] + add_numbers(arr[1..-1]) 
end 

# Test Cases
puts "Exercise 2 - add_numbers"
p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers([]) # => returns nil
puts "--------------------------\n"


#method calculates the gamma function recursively. the gamma function states that for any positive number, n, it equals (n - 1)! 
def gamma_fnc(n)
    return nil if n == 0 
    return 1 if n == 1 
    (n - 1) * gamma_fnc(n - 1)
end 

# Test Cases
puts "Exercise 3 - Gamma Function"
p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040
puts "--------------------------\n"


#method takes in ice cream flavors at a ice cream shop and a favorite flavor. returns boolean of whether favorite flavor is offered by ice cream shop. solves recursively. 
def ice_cream_shop(flavors, fav_flavor)
    return false if flavors.empty? 
    return true if flavors.pop == fav_flavor 
    ice_cream_shop(flavors, fav_flavor) 
end 

# Test Cases
puts "Exercise 4 - Ice Cream Shop"
p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
p ice_cream_shop([], 'honey lavender')  # => returns false
puts "--------------------------\n"


#method reverses a string recursively 
def reverse(string)
    return string if string.length == 1 || string.empty?  
    string[-1] + reverse(string[0...-1]) 
end 

# Test Cases
puts "Exercise 5 - Reverse"
p reverse("house") # => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""
puts "--------------------------\n"