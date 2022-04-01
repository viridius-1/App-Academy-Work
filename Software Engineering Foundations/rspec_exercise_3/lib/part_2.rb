#method returns hash of number of times an element occurs in an array
def element_count(arr)
    count = Hash.new(0)
    arr.each { |el| count[el] += 1 }
    count 
end 

#method mutates a string by replacing the string's characters with their corresponding hash values 
def char_replace!(string, hash)
    string.each_char.with_index { |char, idx| string[idx] = hash[char] if hash.has_key?(char) } 
end 

#method calculates the product of all array elements using inject 
def product_inject(arr)
    arr.inject(:*)
end 