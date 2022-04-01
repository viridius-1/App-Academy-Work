require "byebug"

#method accepts any number of arrays. returns 2D array with subarrays containing all elements at the same index. 
def zip(*arrays)
    answer_arr = []
   
    el_idx = 0 
    while el_idx < arrays[0].length 

        indice_arr = []
        array_num_idx = 0 
        while array_num_idx < arrays.length 
            indice_arr << arrays[array_num_idx][el_idx]
            array_num_idx += 1 
        end 
        answer_arr << indice_arr 
 
        el_idx += 1 
    end 
    
    answer_arr 
end 

#method returns elements in an array for which only 1 of the procs returns true 
def prizz_proc(arr, proc1, proc2)
    arr.select do |el| 
        ( proc1.call(el) == true && proc2.call(el) == false ) || ( proc1.call(el) == false && proc2.call(el) == true )  
    end 
end 

#method accepts any number of arrays. returns 2D array with subarrays containing all elements at the same index. puts nil in places where array is too short. 
def zany_zip(*arrays)
    answer_arr = []
    length = 0 

    arrays.each { |array| length = array.length if array.length > length } 

    el_idx = 0 
    while el_idx < length 

        indice_arr = []
        array_num_idx = 0 
        while array_num_idx < arrays.length 
            indice_arr << arrays[array_num_idx][el_idx]
            array_num_idx += 1 
        end 
        answer_arr << indice_arr 
 
        el_idx += 1 
    end 
    
    answer_arr 
end 

#method accepts array and block. returns element with largest return value when passed to the block. 
def maximum(arr, &prc) 
    if arr.empty? 
        nil 
    else 
        max = arr[0]  
        arr.each { |el| max = el if prc.call(el) >= prc.call(max) }
        max 
    end 
end 

#method accepts array and block. returns hash. keys are the result of the elements being passed to the block and values are an array of element(s) corresponding to the keys.
def my_group_by(arr, &prc)
    hash = Hash.new { |hash, key| hash[key] = [] }
    arr.each { |el| hash[prc.call(el)] << el } 
    hash 
end 

#returns element in array that returns largest value when passed to block. uses proc if there is a tie. if still tie after proc, then return earliest element. 
def max_tie_breaker(arr, prc, &blk)
    if arr 
        largest_qty = nil 
        largest_el = nil 

        arr.each do |el| 
            if largest_qty == nil || blk.call(el) > largest_qty 
                largest_qty = blk.call(el)
                largest_el = el 
            elsif blk.call(el) == largest_qty
                largest_qty, largest_el = eval(largest_qty, largest_el, arr, el, prc) 
            end 
        end 

        largest_el 
    else 
        nil 
    end 
end 

#method returns largest return value based on proc. returns earliest element in array if tie. 
def eval(largest_qty, largest_el, arr, el, prc) 
    if prc.call(el) > largest_qty 
        largest_qty = prc.call(el)
        largest_el = el      
    elsif prc.call(el) == largest_qty 
        if arr.index(el) > arr.index(largest_el)
            largest_qty = prc.call(largest_el) 
        else 
            largest_qty = prc.call(el)
            largest_el = el      
        end 
    end

    [largest_qty, largest_el]
end 

#method takes in sentence. returns new sentence. all letters before first and last vowel are removed. no letters are removed for words with less than 2 vowels.
def silly_syllables(sent)
    vowels = 'aeiou'
    arr = sent.split 

    arr.map! do |word| 
        vwl_ct = 0 
        word.each_char { |char| vwl_ct += 1 if vowels.include?(char) } 

        if vwl_ct < 2 
            word 
        else 
            first_vwl_idx, last_vwl_idx = get_indexes(vowels, word) 
            word[first_vwl_idx..last_vwl_idx] 
        end 
    end 

    arr.join(' ')
end 

#method returns array of first and last vowel indexes of a word 
def get_indexes(vowels, word)
    
    idx = 0 
    while idx < word.length 
        if vowels.include?(word[idx]) 
            first_vwl_idx = idx 
            break 
        end 
        idx += 1 
    end 

    idx = word.length - 1 
    while idx >= 0 
        if vowels.include?(word[idx]) 
            last_vwl_idx = idx 
            break 
        end 
        idx -= 1 
    end 

    [first_vwl_idx, last_vwl_idx]
end 