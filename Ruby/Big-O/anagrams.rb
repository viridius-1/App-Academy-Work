def time(start_time)
    Time.now - start_time
end 

def print_time(start_time)
    puts "Finished in #{time(start_time)} seconds."
    puts "---------------------------------------"
end 

#method returns all anagrams of a string 
def get_anagrams(string)
    combos = string.split('').permutation(string.length).to_a 
    combos.map! { |combo| combo.join }
end 

#method generates all possible anagrams of first string. returns boolean whether 2nd string is one of those anagrams.
#Time O(n^2) 
#Space O(n^2)  
def first_anagram?(str1, str2)
    anagrams = get_anagrams(str1)
    anagrams.include?(str2)
end 

puts "Phase I"
start_time = Time.now 
p first_anagram?('cats', 'tacs')
print_time(start_time)


#method returns boolean of whether str2 is anagram of str1. does this by iterating over each character of str1 and finding that character in str2 and deleting it.....then checking to see if str2 is empty at the end of the iteration of str1
#Time O(n)
#Space O(n)
def second_anagram?(str1, str2)
    str2_arr = str2.split('')

    str1.each_char do |char| 
        index_of_char_in_str2 = str2_arr.index(char)
        str2_arr.delete_at(index_of_char_in_str2)
    end 

    str2_arr.empty? 
end 

puts "Phase II"
start_time = Time.now 
p second_anagram?('cats', 'tacs')
print_time(start_time)


#method returns boolean of whether str2 is anagram of str1. does this by sorting both strings alphabetically. 
#Time O(n log n)
#Space O(n)
def third_anagram?(str1, str2)
    str1.split('').sort.join == str2.split('').sort.join
end 

puts "Phase III"
start_time = Time.now 
p third_anagram?('cats', 'tacs')
print_time(start_time)


#method returns boolean of whether str2 is anagram of str1. does this by creating hashes to store the number of times the letters appear in both words.....and then comparing the hashes
#Time O(n)
#Space O(1)
def fourth_anagram_phase1(str1, str2)
    str1_hash = Hash.new(0)
    str2_hash = Hash.new(0) 

    str1.each_char { |char| str1_hash[char] += 1 }
    str2.each_char { |char| str2_hash[char] += 1 }

    str1_hash == str2_hash 
end 

puts "Phase IV Part I"
start_time = Time.now 
p fourth_anagram_phase1('cats', 'tacs')
print_time(start_time)


#method returns boolean of whether str2 is anagram of str1. does this by using 1 hash. 
#Time O(n)
#Space O(1)
def fourth_anagram_phase2(str1, str2)
    str_hash = Hash.new(0)

    #load hash w/ character count based on str1 
    str1.each_char { |char| str_hash[char] += 1 } 

    #evaluate if str2 is anagram of str1 based on str_hash 
    str2.each_char do |char| 
        occurences_of_char_in_str2 = str2.count(char)
        return false if str_hash[char] != occurences_of_char_in_str2 
    end 
    
    true 
end 

puts "Phase IV Part II"
start_time = Time.now 
p fourth_anagram_phase2('cats', 'tacs')
print_time(start_time)





