require 'pry'
#method that returns true if a string is a palindrome and false if it isn't 
def palindrome?(string)

    rvrs = ""

    idx = string.length - 1 
    while idx >= 0 
        rvrs += string[idx]
        idx -= 1 
    end 

    string == rvrs 
end 

#method that returns an array of all substrings of a string 
def substrings(string)
    subs = []

    idx = 0 
    while idx < string.length 

        cutoff = idx 
        while cutoff < string.length 
            substring = string[idx..cutoff]   
            subs << substring 
            cutoff += 1                 
        end 

        idx += 1 
    end 

    subs 
end 

#method that takes in a string. returns array of substrings that are palindromes and longer than 1 character. 
def palindrome_substrings(string)
    substrings(string).select { |substring| palindrome?(substring) && substring.length > 1 }
end 

