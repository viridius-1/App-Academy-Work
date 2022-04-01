#method that returns the average of 2 nunmbers
def average(num1, num2)
    (num1 + num2)/2.0
end 

#method that returns the average of an array of numbers
def average_array(arr)
    arr.inject(:+)/arr.length.to_f
end 

#method that returns a string repeated a specified number of times
def repeat(string, rpts)
    string * rpts 
end 

#method that returns a string in all caps and an exclamation point at the end 
def yell(string)
    "#{string.upcase}!"
end 

#method that returns a sentence with alternating all capitalized and all lowercase words 
def alternating_case(sentence)
 
    arr = sentence.split 

    arr.each_with_index do |el, idx|
        if idx.even?
            arr[idx] = el.upcase 
        else 
            arr[idx] = el.downcase 
        end 
    end 

    arr.join(" ")
end 

