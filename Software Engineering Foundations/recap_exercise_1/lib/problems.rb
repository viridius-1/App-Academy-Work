require "byebug"
# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
    
    vwl_pairs = []
    vowels = "aeiou"

    idx1 = 0 
    while idx1 < words.length - 1 
        word1 = words[idx1]

        idx2 = idx1 + 1 
        while idx2 < words.length
            word2 = words[idx2]

            paired_words = [word1, word2]
            paired_words_str = paired_words.join 

            valid = true 
            vowels.each_char do |vwl|  
                valid = false if !(paired_words_str.include?(vwl))
            end 
            vwl_pairs << paired_words.join(' ') if valid

            idx2 += 1 
        end 

        idx1 += 1 
    end 

    vwl_pairs 
end 




# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num) 
    (num - 1).downto(2) { |i| return true if num % i == 0 } 
    false 
end 


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    bigrams.select { |bigram| str.include?(bigram) } 
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        new_hash = {}
        if prc == nil 
            self.each { |k, v| new_hash[k] = v if k == v } 
        else  
            self.each { |k, v| new_hash[k] = v if prc.call(k, v) } 
        end 

        new_hash 
    end 
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    
    def substrings(length = nil)
        substrings = get_substrings(self)
        if length == nil 
            substrings 
        else 
            substrings.select { |substring| substring.length == length }
        end 
    end 

    #method that returns the substrings of a string 
    def get_substrings(string)
        substrings = []

        idx1 = 0 
        while idx1 < string.length 

            idx2 = idx1 
            while idx2 < string.length 
                substrings << string[idx1..idx2]
                idx2 += 1 
            end 

            idx1 += 1 
        end 

        substrings 
    end 

    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    
    def caesar_cipher(num)

        alphabet = "abcdefghijklmnopqrstuvwxyz" 

        self.each_char.with_index do |char, idx| 
            new_idx = (alphabet.index(char) + num) % alphabet.length 
            self[idx] = alphabet[new_idx]
        end 

        self 
    end 



end
