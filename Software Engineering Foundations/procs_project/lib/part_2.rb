#method accepts string and block. returns reversed string with block execution. 
def reverser(string, &prc)
    string.reverse!
    prc.call(string)
end 

#method accepts sentence and block. returns new sentence with words modified by block execution. 
def word_changer(sent, &prc)
    sent_arr = sent.split 
    sent_arr.map! { |word| prc.call(word) }
    sent_arr.join(' ')
end 

#method accepts a number and 2 procs. returns greates value when n is passed to both procs.
def greater_proc_value(n, prc1, prc2)
    [prc1.call(n), prc2.call(n)].max
end 

#method accepts array and 2 procs. returns array elements that result in true when passed into both procs. 
def and_selector(arr, prc1, prc2)
    arr.select { |el| el if prc1.call(el) && prc2.call(el) } 
end 

#method accepts array and 2 procs. returns new array where each even index element is executed by first proc and each odd index element is executed by 2nd proc. 
def alternating_mapper(arr, prc1, prc2)
    arr.map.with_index do |el, idx| 
        if idx.even? 
            prc1.call(el)
        else 
            prc2.call(el)    
        end 
    end 
end 