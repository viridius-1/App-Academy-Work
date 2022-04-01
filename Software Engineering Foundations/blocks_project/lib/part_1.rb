#method that returns the even numbers of an array
def select_even_nums(arr)
    arr.select(&:even?)
end 

#method that returns an array of hashes containing dogs older than 2 
def reject_puppies(dogs)
    dogs.reject { |dog_hash| dog_hash["age"] <= 2 } 
end 

#method that takes in 2D array or subarrays. returns qty of subarrays where numbers sum to a positive number. 
def count_positive_subarrays(arr)
    arr.count { |sub_arr| sub_arr.sum > 0 }
end 

#method that adds a 'b' after every vowel and that same vowel after the b 
def aba_translate(string)

    new_string = ""
    vowels = "aeiou"

    string.each_char do |char| 
        if vowels.include?(char)
            new_string += "#{char}b#{char}" 
        else 
            new_string += char 
        end 
    end 

    new_string 
end 

#method that returns an array of words into aba translated words. it adds a 'b' after every vowel and that same vowel after the b. 
def aba_array(arr)
    arr.map { |word| aba_translate(word) } 
end 