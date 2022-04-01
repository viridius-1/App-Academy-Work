require 'pry'

#method that makes a 2d array. 1st subarray contains numbers less than intake number argument. 2nd subarray contains numbers greater than or equal to number argument. 
def partition(arr, n)
    less_than_n = []
    grtr_eql_n = []

    arr.each do |num| 
        if num < n 
            less_than_n << num 
        else 
            grtr_eql_n << num 
        end 
    end 

    [less_than_n, grtr_eql_n]
end 

#method that merges 2 hashes. if hashes have identical keys, only accept key-value pair of hash 2. 
def merge(hash1, hash2)

    merged = {}

    #load merged with hash1 
    hash1.each { |ltr, num| merged[ltr] = num }

    #add hash2 to merged. account for possible duplicate key. 
    hash2.each { |ltr, num| merged[ltr] = num }

    merged 
end 

#method that takes in a sentence and an array of curse words. replaces vowels of curse words with *.
def censor(sentence, curse_words)

    sentence_arr = sentence.split 
    
    sentence_arr.map! do |word| 
        if curse_words.include?(word.downcase)
            modified_word = edit_vowels(word)
        else 
            word 
        end 
    end 

    sentence_arr.join(" ")
end 

#method that replaces each vowel in a curse word with * 
def edit_vowels(word)

    vowels = "aeiou"

    word.each_char.with_index { |char, idx| word[idx] = "*" if vowels.include?(char.downcase) } 

    word
end 

#method that returns a boolean indicating whether a number is a power of 2 
def power_of_two?(num)

    while true 
        if num == 2 || num == 1 
            return true 
        elsif num % 2 != 0 
            return false 
        else 
            num = num / 2 
        end  
    end 

end 
