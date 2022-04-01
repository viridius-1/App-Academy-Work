
#method that returns a word with its last vowel removed. if word has no vowels, then returns the word unchanged. 
def hipsterfy(word)

    vowels = "aeiou"

    idx = word.length - 1 

    while idx >= 0 
        ltr = word[idx]
        if vowels.include?(ltr)
            return word[0...idx] + word[idx + 1..-1]
        end 
        idx -= 1 
    end 

    word 
end 

#method that returns a hash of letters and their occurences in a string 
def vowel_counts(string)

    vwl_cts = Hash.new(0)
    string.downcase! 
    vowels = "aeiou"

    string.each_char { |char| vwl_cts[char] += 1 if vowels.include?(char) } 

    vwl_cts 
end 

#method that does a caesar cipher. takes string and number, n. shifts each letter n places in the alphabet.
def caesar_cipher(string, n)
    alphabet = "abcdefghijklmnopqrstuvwxyz"

    string.each_char.with_index do |char, idx| 
        if alphabet.include?(char)
            orig_idx = alphabet.index(char) 
            new_idx = (orig_idx + n) % alphabet.length 
            string[idx] = alphabet[new_idx]
        end 
    end 

    string 
end 