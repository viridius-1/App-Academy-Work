require "byebug"

#method returns a boolean of whether at least 1 array element returns true when passed to the block 
def some?(arr, &prc)
    arr.each { |el| return true if prc.call(el) }
    false 
end 

puts "Some?"
p some?([3, 1, 11, 5]) { |n| n.even? }                                # false
p some?([3, 4, 11, 5]) { |n| n.even? }                                # true
p some?([8, 2]) { |n| n.even? }                                       # true
p some?(['squash', 'corn', 'kale', 'carrot']) { |str| str[0] == 'p' } # false
p some?(['squash', 'corn', 'kale', 'potato']) { |str| str[0] == 'p' } # true
p some?(['parsnip', 'lettuce', 'pea']) { |str| str[0] == 'p' }        # true
puts "---------------------------------\n\n\n"



#method takes in array, number, block. returns true if there are exactly the number of elements in the array that return true when passed to the block.
def exactly?(arr, num, &prc)
    ct = 0 
    arr.each { |el| ct += 1 if prc.call(el) }
    ct == num 
end 

puts "Exactly?"
p exactly?(['A', 'b', 'C'], 2) { |el| el == el.upcase }         # true
p exactly?(['A', 'B', 'C'], 2) { |el| el == el.upcase }         # false
p exactly?(['A', 'B', 'C'], 3) { |el| el == el.upcase }         # true
p exactly?(['cat', 'DOG', 'bird'], 1) { |el| el == el.upcase }  # true
p exactly?(['cat', 'DOG', 'bird'], 0) { |el| el == el.upcase }  # false
p exactly?(['cat', 'dog', 'bird'], 0) { |el| el == el.upcase }  # true
p exactly?([4, 5], 3) { |n| n > 0 }                             # false
p exactly?([4, 5, 2], 3) { |n| n > 0 }                          # true
p exactly?([42, -9, 7, -3, -6], 2) { |n| n > 0 }                # true
puts "---------------------------------\n\n\n"


#method returns new array where elements that are passed to the block are removed if they return true 
def filter_out(arr, &prc)
    new_arr = []
    arr.each { |el| new_arr << el unless prc.call(el) }
    new_arr
end 

puts "Filter Out" 
p filter_out([10, 6, 3, 2, 5 ]) { |x| x.odd? }      # [10, 6, 2]
p filter_out([1, 7, 3, 5 ]) { |x| x.odd? }          # []
p filter_out([10, 6, 3, 2, 5 ]) { |x| x.even? }     # [3, 5]
p filter_out([1, 7, 3, 5 ]) { |x| x.even? }         # [1, 7, 3, 5]
puts "---------------------------------\n\n\n"


#method takes in array, number, block. returns boolean of whether at least the number of elements in array return true when passed to the block. 
def at_least?(arr, num, &prc)
    ct = 0 
    arr.each do |el| 
        ct += 1 if prc.call(el)
        return true if ct == num 
    end 
    false 
end 


puts "At Least" 
p at_least?(['sad', 'quick', 'timid', 'final'], 2) { |s| s.end_with?('ly') }
# false
p at_least?(['sad', 'quickly', 'timid', 'final'], 2) { |s| s.end_with?('ly') }
# false
p at_least?(['sad', 'quickly', 'timidly', 'final'], 2) { |s| s.end_with?('ly') }
# true
p at_least?(['sad', 'quickly', 'timidly', 'finally'], 2) { |s| s.end_with?('ly') }
# true
p at_least?(['sad', 'quickly', 'timid', 'final'], 1) { |s| s.end_with?('ly') }
# true
p at_least?(['sad', 'quick', 'timid', 'final'], 1) { |s| s.end_with?('ly') }
# false
p at_least?([false, false, false], 3) { |bool| bool }
# false
p at_least?([false, true, true], 3) { |bool| bool }
# false
p at_least?([true, true, true], 3) { |bool| bool }
# true
p at_least?([true, true, true, true], 3) { |bool| bool }
# true
puts "---------------------------------\n\n\n"


#method takes in array & block. returns boolean of whether every element in array results in true when passed to the block. 
def every?(arr, &prc)
    arr.each { |el| return false unless prc.call(el) }
    true 
end 

puts "Every" 
p every?([3, 1, 11, 5]) { |n| n.even? }                                 # false
p every?([2, 4, 4, 8]) { |n| n.even? }                                  # true
p every?([8, 2]) { |n| n.even? }                                        # true
p every?(['squash', 'corn', 'kale', 'carrot']) { |str| str[0] == 'p' }  # false
p every?(['squash', 'pea', 'kale', 'potato']) { |str| str[0] == 'p' }   # false
p every?(['parsnip', 'potato', 'pea']) { |str| str[0] == 'p' }          # true
puts "---------------------------------\n\n\n"


#method takes in array, number, block. returns boolean indicating whether no more than the number of elements return true when passed to block. 
def at_most?(arr, num, &prc)
    ct = 0 
    arr.each do |el| 
        ct += 1 if prc.call(el) 
        return false if ct > num 
    end 
    true 
end 

puts "At Most"
p at_most?([-4, 100, -3], 1) { |el| el > 0 }                         # true
p at_most?([-4, -100, -3], 1) { |el| el > 0 }                        # true
p at_most?([4, 100, -3], 1) { |el| el > 0 }                          # false
p at_most?([4, 100, 3], 1) { |el| el > 0 }                           # false
p at_most?(['r', 'q', 'e', 'z'], 2) { |el| 'aeiou'.include?(el) }    # true
p at_most?(['r', 'i', 'e', 'z'], 2) { |el| 'aeiou'.include?(el) }    # true
p at_most?(['r', 'i', 'e', 'o'], 2) { |el| 'aeiou'.include?(el) }    # false
puts "---------------------------------\n\n\n"


#method accepts array & block. returns index of first element resulting in true when passed to the block. 
def first_index(arr, &prc)
    arr.each_with_index { |el, idx| return idx if prc.call(el) } 
    nil 
end 

puts "First Index"
p first_index(['bit', 'cat', 'byte', 'below']) { |el| el.length > 3 }           # 2
p first_index(['bitten', 'bit', 'cat', 'byte', 'below']) { |el| el.length > 3 } # 0
p first_index(['bitten', 'bit', 'cat', 'byte', 'below']) { |el| el.length > 6 } # nil
p first_index(['bit', 'cat', 'byte', 'below']) { |el| el[0] == 'b' }            # 0
p first_index(['bit', 'cat', 'byte', 'below']) { |el| el.include?('a') }        # 1
p first_index(['bit', 'cat', 'byte', 'below']) { |el| el[0] == 't' }            # nil
puts "---------------------------------\n\n\n"



#method accepts array & 2 procs. returns elements of array that return true for both procs or return false for both procs 
def xnor_select(arr, prc1, prc2)
    arr.select { |el| el if prc1.call(el) && prc2.call(el) || !prc1.call(el) && !prc2.call(el) } 
end 

puts "Xnor Select"
is_even = Proc.new { |n| n % 2 == 0 }
is_odd = Proc.new { |n| n % 2 != 0 }
is_positive = Proc.new { |n| n > 0 }
p xnor_select([8, 3, -4, -5], is_even, is_positive)         # [8, -5]
p xnor_select([-7, -13, 12, 5, -10], is_even, is_positive)  # [-7, -13, 12]
p xnor_select([-7, -13, 12, 5, -10], is_odd, is_positive)   # [5, -10]
puts "---------------------------------\n\n\n"


#method accepts array & block. removes elements that result in true when being passed to the block. 
def filter_out!(arr, &prc)
    arr.map! do |el| 
        if prc.call(el)
            nil 
        else 
            el
        end  
    end 
    arr.delete(nil)
end 

puts "Filter Out!"
arr_1 = [10, 6, 3, 2, 5 ]
filter_out!(arr_1) { |x| x.odd? }
p arr_1     # [10, 6, 2]

arr_2 = [1, 7, 3, 5 ]
filter_out!(arr_2) { |x| x.odd? }
p arr_2     # []

arr_3 = [10, 6, 3, 2, 5 ]
filter_out!(arr_3) { |x| x.even? }
p arr_3     # [3, 5]

arr_4 = [1, 7, 3, 5 ]
filter_out!([1, 7, 3, 5 ]) { |x| x.even? }
p arr_4 # [1, 7, 3, 5]
puts "---------------------------------\n\n\n"


#method accepts array, optional number n, and block. returns array with each element passed to the block n times. if no n is given then n is 1. 
def multi_map(arr, n=1, &prc)
    arr.map do |el| 
        acc = el     
        n.times { acc = prc.call(acc) } 
        acc 
    end 
end 

puts "Multi Map"
p multi_map(['pretty', 'cool', 'huh?']) { |s| s + '!'}      # ["pretty!", "cool!", "huh?!"]
p multi_map(['pretty', 'cool', 'huh?'], 1) { |s| s + '!'}   # ["pretty!", "cool!", "huh?!"]
p multi_map(['pretty', 'cool', 'huh?'], 3) { |s| s + '!'}   # ["pretty!!!", "cool!!!", "huh?!!!"]
p multi_map([4, 3, 2, 7], 1) { |num| num * 10 }             # [40, 30, 20, 70]
p multi_map([4, 3, 2, 7], 2) { |num| num * 10 }             # [400, 300, 200, 700]
p multi_map([4, 3, 2, 7], 4) { |num| num * 10 }             # [40000, 30000, 20000, 70000]
puts "---------------------------------\n\n\n"


#method accepts array & block. returns new array. elements that return true when passed to block are in front of elements that return false. element order of original arrahy is maintained. 
def proctition(arr, &prc)
    true_els = []
    false_els = []

    arr.each do |el| 
        if prc.call(el) 
            true_els << el 
        else 
            false_els << el     
        end 
    end 

    true_els + false_els
end 

puts "Proctition"
p proctition([4, -5, 7, -10, -2, 1, 3]) { |el| el > 0 }
# [4, 7, 1, 3, -5, -10, -2]

p proctition([7, 8, 3, 6, 10]) { |el| el.even? }
# [8, 6, 10, 7, 3]

p proctition(['cat','boot', 'dog', 'bug', 'boat']) { |s| s[0] == 'b' }
# ["boot", "bug", "boat", "cat", "dog"]
puts "---------------------------------\n\n\n"


#method accepts array and 2 procs. mutates array by replacing elements passed to first proc that return true with elements passed to 2nd proc. method returns nil. 
def selected_map!(arr, prc1, prc2)
    arr.map! do |el| 
        if prc1.call(el)
            prc2.call(el)
        else 
            el    
        end 
    end 
    nil 
end 

puts "Selected Map"
is_even = Proc.new { |n| n.even? }
is_positive = Proc.new { |n| n > 0 }
square = Proc.new { |n| n * n }
flip_sign = Proc.new { |n| -n }

arr_1 = [8, 5, 10, 4]
p selected_map!(arr_1, is_even, square)     # nil
p arr_1                                     # [64, 5, 100, 16]

arr_2 = [-10, 4, 7, 6, -2, -9]
p selected_map!(arr_2, is_even, flip_sign)  # nil
p arr_2                                     # [10, -4, 7, -6, 2, -9]

arr_3 = [-10, 4, 7, 6, -2, -9]
p selected_map!(arr_3, is_positive, square) # nil
p arr_3                                     # [-10, 16, 49, 36, -2, -9]
puts "---------------------------------\n\n\n"


#method accepts value and array of procs. returns result of passing value through each proc.
def chain_map(num, procs)
    procs.each { |proc| num = proc.call(num) }
    num 
end 

puts "Chain Map"
add_5 = Proc.new { |n| n + 5 }
half = Proc.new { |n| n / 2.0 }
square = Proc.new { |n| n * n }

p chain_map(25, [add_5, half])          # 15.0
p chain_map(25, [half, add_5])          # 17.5
p chain_map(25, [add_5, half, square])  # 225
p chain_map(4, [square, half])          # 8
p chain_map(4, [half, square])          # 4
puts "---------------------------------\n\n\n"


#method accepts string and hash where keys are procs and values are string suffixes. method returns new sentence where each word receives suffix if word returns true when passed to proc key.
def proc_suffix(sent, hash)
    sent_arr = sent.split 

    sent_arr.map! do |word|
        copy = word 
        hash.each { |proc, suffix| word += suffix if proc.call(copy) } 
        word 
    end 

    sent_arr.join(' ')
end 

puts "Proc Suffix"
contains_a = Proc.new { |w| w.include?('a') }
three_letters = Proc.new { |w| w.length == 3 }
four_letters = Proc.new { |w| w.length == 4 }

p proc_suffix('dog cat',
    contains_a => 'ly',
    three_letters => 'o'
)   # "dogo catlyo"

p proc_suffix('dog cat',
    three_letters => 'o',
    contains_a => 'ly'
)   # "dogo catoly"

p proc_suffix('wrong glad cat',
    contains_a => 'ly',
    three_letters => 'o',
    four_letters => 'ing'
)   # "wrong gladlying catlyo"

p proc_suffix('food glad rant dog cat',
    four_letters => 'ing',
    contains_a => 'ly',
    three_letters => 'o'
)   # "fooding gladingly rantingly dogo catlyo"
puts "---------------------------------\n\n\n"


#method accepts array and any number of procs. returns hash. keys are number of proc. values are elements of array that return true when passed to block. if element returns true for multiple procs then only put into array corresponding to first proc that returns true.
def proctition_platinum(arr, *procs)
    used = []
    hash = {}

    #set up hash 
    (1..procs.length).each { |i| hash[i] = [] }

    arr.each do |el| 
        procs.each_with_index do |proc, idx| 
            if proc.call(el) && !used.include?(el) 
                hash[idx + 1] << el 
                used << el 
            end 
        end 
    end 

    hash 
end 

puts "Proctition Platinum"
is_yelled = Proc.new { |s| s[-1] == '!' }
is_upcase = Proc.new { |s| s.upcase == s }
contains_a = Proc.new { |s| s.downcase.include?('a') }
begins_w = Proc.new { |s| s.downcase[0] == 'w' }

p proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], is_yelled, contains_a)
# {1=>["when!", "WHERE!"], 2=>["what"]}

p proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], is_yelled, is_upcase, contains_a)
# {1=>["when!", "WHERE!"], 2=>["WHO", "WHY"], 3=>["what"]}

p proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], is_upcase, is_yelled, contains_a)
# {1=>["WHO", "WHERE!", "WHY"], 2=>["when!"], 3=>["what"]}

p proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], begins_w, is_upcase, is_yelled, contains_a)
# {1=>["WHO", "what", "when!", "WHERE!", "WHY"], 2=>[], 3=>[], 4=>[]}
puts "---------------------------------\n\n\n"


#method accepts sentence and any number of procs in a hash. replaces word in sentence if that word returns true when passed into hash key with value when passed into hash value. 
def procipher(sent, procs)
    sent_arr = sent.split 

    sent_arr.map! do |word| 
        copy = word 
        procs.each { |proc_key, proc_val| word = proc_val.call(word) if proc_key.call(copy) } 
        word 
    end 

    sent_arr.join(' ')
end 



puts "Procipher"
is_yelled = Proc.new { |s| s[-1] == '!' }
is_upcase = Proc.new { |s| s.upcase == s }
contains_a = Proc.new { |s| s.downcase.include?('a') }
make_question = Proc.new { |s| s + '???' }
reverse = Proc.new { |s| s.reverse }
add_smile = Proc.new { |s| s + ':)' }

p procipher('he said what!',
    is_yelled => make_question,
    contains_a => reverse
) # "he dias ???!tahw"

p procipher('he said what!',
    contains_a => reverse,
    is_yelled => make_question
) # "he dias !tahw???"

p procipher('he said what!',
    contains_a => reverse,
    is_yelled => add_smile
) # "he dias !tahw:)"

p procipher('stop that taxi now',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "stop that??? taxi??? now"

p procipher('STOP that taxi now!',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "STOP:) that??? taxi??? !won"
puts "---------------------------------\n\n\n"


#method accepts sentence and hash of procs. changes each sentence word with value proc if word returns true when passed to corresponding key proc. if word returns true for multiple key procs then only return result when passed into first value proc that returns true when passed into key proc. 
def picky_procipher(sent, procs)
    sent_arr = sent.split 

    sent_arr.map! do |word| 
        procs.each do |proc_key, proc_val| 
            if proc_key.call(word)
                word = proc_val.call(word)
                break 
            end 
        end 
        word 
    end 

    sent_arr.join(' ')
end 

puts "Picky Procipher"
is_yelled = Proc.new { |s| s[-1] == '!' }
is_upcase = Proc.new { |s| s.upcase == s }
contains_a = Proc.new { |s| s.downcase.include?('a') }
make_question = Proc.new { |s| s + '???' }
reverse = Proc.new { |s| s.reverse }
add_smile = Proc.new { |s| s + ':)' }

p picky_procipher('he said what!',
    is_yelled => make_question,
    contains_a => reverse
) # "he dias what!???"

p picky_procipher('he said what!',
    contains_a => reverse,
    is_yelled => make_question
) # "he dias !tahw"

p picky_procipher('he said what!',
    contains_a => reverse,
    is_yelled => add_smile
) # "he dias !tahw"

p picky_procipher('stop that taxi now',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "stop that??? taxi??? now"

p picky_procipher('STOP that taxi!',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "STOP:) that??? !ixat"
puts "---------------------------------\n\n\n"