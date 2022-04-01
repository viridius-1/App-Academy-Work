#method accepts array and block. returns new array where each element passed into block results in false. 
def my_reject(arr, &prc)
    arr.select { |el| prc.call(el) == false } 
end 

#method accepts array and block. returns true when just 1 element in array results in true when passed into block. 
def my_one?(arr, &prc)
    trues = []
    arr.each { |el| trues << el if prc.call(el) }
    if trues.length == 1 
        true 
    else 
        false 
    end 
end 

#method that returns the key-value pairs of a hash that result in true when passed into the block 
def hash_select(hash, &prc)
    true_vals = {}
    hash.each { |k, v| true_vals[k] = v if prc.call(k, v) }
    true_vals 
end 

#method returns elements of array where 1 proc is true and the other is false 
def xor_select(arr, prc1, prc2)
    arr.select do |el| 
        ( prc1.call(el) == true && prc2.call(el) == false ) || ( prc1.call(el) == false && prc2.call(el) == true ) 
    end 
end 

#method accepts value and array of proc objects. returns number of procs in array that result in true when value is passed in. 
def proc_count(val, procs)
    procs.count { |proc| proc.call(val) } 
end 
