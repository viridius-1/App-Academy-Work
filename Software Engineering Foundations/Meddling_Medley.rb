#method returns the number of times a character repeats most in a string 
def duos(string)
   rpts = 0 

   idx1 = 0 
   while idx1 < string.length - 1 
        idx2 = idx1 + 1 
        rpts += 1 if string[idx1] == string[idx2]
        idx1 += 1 
   end 

   rpts 
end 

puts "Duos"
p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0
puts"-----------------------------\n\n\n"


#method accepts sentence and hash. replaces each word in sentence with corresponding value hash if hash has that word as a key. 
def sentence_swap(sent, hash)
    sent_arr = sent.split 
    sent_arr.map! do |word| 
        if hash.has_key?(word) 
            hash[word] 
        else 
            word 
        end 
    end 
    sent_arr.join(' ')
end 

puts "Sentence Swap"
p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'
puts"-----------------------------\n\n\n"


#method accepts hash, proc, & clock. returns new hash where keys are the result when passed to the block and values are the result when passed to the proc. 
def hash_mapped(hash, prc, &blk)
    new_hash = {}
    hash.each { |k, v| new_hash[blk.call(k)] = prc.call(v) } 
    new_hash
end 

puts "Hash Mapped"
double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}
puts"-----------------------------\n\n\n"


#method returns the characters in an array that appear more than twice 
def counted_characters(string)
    mult_chars = []
    string.each_char { |char| mult_chars << char if string.count(char) > 2 && !mult_chars.include?(char) } 
    mult_chars 
end 

puts "Counted Characters"
p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []
puts"-----------------------------\n\n\n"


#method returns boolean of a character appears 3 times in a row in a string 
def triplet_true(string)
    idx = 0 
    while idx < string.length - 2 
        return true if string[idx] == string[idx + 1] && string[idx] == string[idx + 2]
        idx += 1 
    end 
    false 
end 

puts "Triplet True"
p triplet_true('caaabb')        # true
p triplet_true('terrrrrible')   # true
p triplet_true('runninggg')     # true
p triplet_true('bootcamp')      # false
p triplet_true('e')             # false
puts"-----------------------------\n\n\n"


#method accepts string and hash. returns new string where each letter is replaced with hash's key's value. if no key then replaces with '?'. spaces remain unchanged.
def energetic_encoding(string, hash)
    new_str = ''
    string.each_char do |char| 
        if hash.has_key?(char) 
            new_str += hash[char]
        elsif char == ' '
            new_str += ' '
        else 
            new_str += '?'
        end 
    end 
    new_str
end 

puts "Energetic Encoding"
p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'
puts"-----------------------------\n\n\n"


#methd returns new string where each character in original string is repeated the number of times by the number that comes after it 
def uncompress(string)
    new_str = ''
    idx = 0 
    while idx < string.length - 1 
        new_str += string[idx] * string[idx + 1].to_i
        idx += 2 
    end 
    new_str
end 

puts "Uncompress"
p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'
puts"-----------------------------\n\n\n"


#method accepts array. returns new array where elements returns true when passed into all procs. 
def conjunct_select(arr, *procs)
    arr.select do |el| 
        procs.each do |proc| 
            break unless proc.call(el)
            el 
        end 
    end 
end 

puts "Conjuct Select"
is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]
puts"-----------------------------\n\n\n"


#method converts a string to pig latin.
def convert_pig_latin(string)
    vowels = 'aeiou'
    arr = string.split 

    arr.map! do |word| 
        if word.length < 3 
            word 
        else 
            word = translate(word, vowels)
        end 
    end 

    arr.join(' ')
end 

#method that translates a word to pig latin 
def translate(word, vowels)
    capitalized = false 

    if vowels.include?(word[0].downcase)
        word + 'yay'
    else 
        capitalized = true if word[0] == word[0].upcase

        first_vwl_idx = nil 
        word.each_char.with_index do |char, idx| 
            if vowels.include?(char) 
                first_vwl_idx = idx 
                break 
            end 
        end 

        word = word[first_vwl_idx..-1] + word[0...first_vwl_idx] + 'ay'
        word.capitalize! if capitalized 
        word 
    end 
end 

puts "Convert Pig Latin"
p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"
puts"-----------------------------\n\n\n"


#method that does a reverberate
def reverberate(string)
    vowels = 'aeiou'
    arr = string.split 

    arr.map! do |word| 
        if word.length < 3 
            word 
        else 
            translate(word, vowels)
        end 
    end 

    arr.join(' ')
end 

#method that translates a word according to reverberate rules 
def translate(word, vowels)
    capitalized = false 
    capitalized = true if word[0] == word[0].upcase 

    if vowels.include?(word[-1])
        word += word 
    else 
        last_vwl_idx = nil 
        idx = word.length - 1 
        while idx >= 0 
            if vowels.include?(word[idx]) 
                word += word[idx..-1] 
                break 
            end 
            idx -= 1 
        end 
    end 

    word.capitalize! if capitalized 
    word 
end 

puts "Reverberate"
p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"
puts"-----------------------------\n\n\n"


#method accepts array and any number of procs. returns array of elements that return true when passed into at least 1 proc. 
def disjunct_select(arr, *procs)
    new_arr = []
    arr.select do |el| 
        procs.each do |proc| 
            if proc.call(el)
                new_arr << el    
                break 
            end 
        end 
    end 
    new_arr 
end 

puts "Disjunct Select"
longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]
puts"-----------------------------\n\n\n"


#method that removes alternating vowels of a sentence. 
def alternating_vowel(sent)
    vowels = 'aeiou'
    sent_arr = sent.split 

    sent_arr.map!.each_with_index do |word, idx| 
        if has_vowels?(word, vowels)  
            new_word(word, idx, vowels) 
        else 
            word 
        end 
    end 

    sent_arr.join(' ')
end 

#method returns boolean of whether a word has vowels 
def has_vowels?(word, vowels) 
    word.each_char { |char| return true if vowels.include?(char) }
    false 
end 

#method returns new word according to alternating vowels rules 
def new_word(word, idx, vowels)
    if idx.even?
        word.each_char.with_index { |char, idx| return word[0...idx] + word[idx + 1..-1] if vowels.include?(char) } 
    else 
        idx = word.length - 1 
        while idx >= 0 
            return word[0...idx] + word[idx + 1..-1] if vowels.include?(word[idx]) 
            idx -= 1 
        end 
    end 
end 

puts "Alternating Vowel"
p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"
puts"-----------------------------\n\n\n"


#method that makes silly talk 
def silly_talk(string)
    vowels = 'aeiou'
    str_arr = string.split 

    str_arr.map! do |word| 
        if vowels.include?(word[-1].downcase) 
            word + word[-1]
        else 
            silly_translate(word, vowels)
        end 
    end 

    str_arr.join(' ')
end 

#method that makes a silly word 
def silly_translate(word, vowels)
    capitalized = false 
    capitalized = true if word[0] == word[0].upcase 

    new_word = ''
    word.each_char do |char| 
        if vowels.include?(char.downcase)
            new_word += char + 'b' + char 
        else 
            new_word += char 
        end 
    end 

    new_word.capitalize! if capitalized
    new_word 
end 

puts "Silly Talk"
p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"
puts"-----------------------------\n\n\n"


#method that compresses a string. consecutive letters have the number of times they repeat after it. single letters receive no numbers after them. 
def compress(string)
    compressed = ''

    idx = 0 
    while idx < string.length 
        if string[idx] == string[idx + 1]
            rpts, idx = get_repeats(string, idx)
            compressed += string[idx] + rpts.to_s 
        else 
            compressed += string[idx]  
        end 
        idx +=1 
    end 

    compressed
end 

#method returns the number of times a letter repeats in a string. also returns proper index to continue evaluating letter repeats. 
def get_repeats(string, idx) 
    rpts = 1  
    while idx < string.length 
        if string[idx] == string[idx + 1]
            rpts += 1 
        else
            break  
        end 
        idx += 1 
    end 

    [rpts, idx]
end 

puts "Compress"
p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"
puts"-----------------------------\n\n\n"