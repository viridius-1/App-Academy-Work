#method accepts array and block. returns array of each element executed by block. 
def my_map(arr, &prc)
    new_arr = []
    arr.each { |el| new_arr << prc.call(el) }
    new_arr 
end 

#method accepts array and block. returns array of each element that results in true when executed by block. 
def my_select(arr, &prc)
    new_arr = []
    arr.each { |el| new_arr << el if prc.call(el) }
    new_arr
end 

#method accepts array and block. returns count of array elements that return true when executed by block. 
def my_count(arr, &prc)
    ct = 0 
    arr.each { |el| ct += 1 if prc.call(el) }
    ct 
end 

#method accepts array and block. returns true when at least 1 array element results in true when executed by block. returns false when all elements executed by block return false.
def my_any?(arr, &prc)
    arr.each { |el| return true if prc.call(el) } 
    false 
end 

#method accepts array and block. returns true when all elements of array equal true when executed by block. returns false if 1 element returns false when executed by block. 
def my_all?(arr, &prc)
    arr.each { |el| return false if !prc.call(el) }
    true 
end 

#method accepts array and block. returns true when none of the array elements result in true with block execution. returns false when 1 element results in true with block execution.
def my_none?(arr, &prc)
    arr.each { |el| return false if prc.call(el) }
    true 
end 