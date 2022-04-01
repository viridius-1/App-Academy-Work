require "byebug"

class Array 

    #method takes in block. calls block on each array element. returns array. 
    def my_each(&prc)
        self.length.times do |i| 
            prc.call(self[i]) 
        end 
        self 
    end 

    #method accepts block. returns array of the elements that satisfy block. 
    def my_select(&prc)
        selections = []
        self.my_each { |el| selections << el if prc.call(el) } 
        selections 
    end 

    #method accepts block. returns array of elements that don't sataisfy block 
    def my_reject(&prc)
        selections = []
        self.my_each { |el| selections << el unless prc.call(el) } 
        selections 
    end 

    #returns boolean of whether any array elements satisfy block 
    def my_any?(&prc)
        self.each { |el| return true if prc.call(el) } 
        false 
    end 

    #returns boolean of whether all array elements satisfy block 
    def my_all?(&prc)
        self.each { |el| return false unless prc.call(el) } 
        true 
    end 

    #method flattens an array recursively
    def my_flatten 
        flattened = []

        self.each do |el| 
            if !el.is_a?(Array)
                flattened += [el]
            else 
                flattened += el.my_flatten 
            end 
        end 

        flattened 
    end 

    #method takes in any number of arrays. returns new array of self.length elements. each element of new array has length of the input arguments + 1 and contains the merged elements at that index. if the size of any argument is less than self, then nil is returned for that location. 
    def my_zip(*arrays)
        new_array = []

        self.each_with_index do |self_el, idx| 
            new_sub_arr = []
            new_sub_arr << self_el  
            arrays.each { |sub_arr| new_sub_arr << sub_arr[idx] } 
            new_array << new_sub_arr 
        end 

        new_array 
    end 

    #method that rotates an array
    def my_rotate(rotation=1) 
        if rotation > 0 
            rotation.times do 
                ltr = self.shift 
                self.push(ltr) 
            end 
        elsif rotation < 0 
            (-rotation).times do 
                ltr = self.pop                 
                self.unshift(ltr) 
            end 
        end 
        self 
    end 

    #method that joins elements of an array with the given parameter. if none given, then uses empty string. 
    def my_join(separator='')
        str = ''
        self.each_with_index do |el, idx| 
            str += el 
            str += separator if idx < self.length - 1 
        end 
        str 
    end 
    
    #method returns new array containing elements in reverse order 
    def my_reverse
        reversed = []

        idx = self.length - 1 
        while idx >= 0 
            reversed << self[idx] 
            idx -= 1  
        end 

        reversed 
    end 


end 