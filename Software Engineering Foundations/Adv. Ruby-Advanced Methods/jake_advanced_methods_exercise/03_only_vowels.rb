# Write a method, `only_vowels?(str)`, that accepts a string as an arg.
# The method should return true if the string contains only vowels.
# The method should return false otherwise.

#method that returns true if a string has only vowels and false if it doesn't 
def only_vowels?(str)
    str.split("").all? { |ltr| "aeiou".include?(ltr) }
end 


p only_vowels?("aaoeee")  # => true
p only_vowels?("iou")     # => true
p only_vowels?("cat")     # => false
p only_vowels?("over")    # => false


