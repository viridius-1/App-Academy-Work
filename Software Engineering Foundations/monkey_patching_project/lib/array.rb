class Array 

    #sorts array. returns largest minus smallest number. returns nil if empty. 
    def span 
        return nil if self.empty? 
        self.sort! 
        self.last - self.first 
    end 

    #returns avg of array. returns nil if empty. 
    def average 
        return nil if self.empty?
        self.sum / self.length.to_f
    end 

    #sorts array. returns median when odd # of elements. returns avg of middle numbers when array has even number of elements. returns nil if empty.
    def median 
        return nil if self.empty?

        self.sort! 

        if self.length.odd? 
            median_place = self.length / 2 
            self[median_place]
        else 
            last_num = self.length / 2 
            first_num = last_num - 1 
            (self[last_num] + self[first_num]) / 2.to_f 
        end 
    end 

    #returns hash which counts # of occurences of each element in array
    def counts
        counts = Hash.new(0)
        self.each { |ltr| counts[ltr] += 1 } 
        counts 
    end 

    #counts the number of times an element occurs in an array
    def my_count(el)
        count = 0 
        self.each { |char| count += 1 if char == el } 
        count 
    end 

    #returns smallest index in array where element occurs. returns nil if element not in array. 
    def my_index(ele)
        self.each_with_index { |char, idx| return idx if char == ele } 
        nil 
    end 

    #returns unique elements in an array 
    def my_uniq
        uniqs = []

        self.each { |char| uniqs << char if !uniqs.include?(char) } 

        uniqs 
    end 

    #transposes array. converts rows to columns. 
    def my_transpose
        
        transposed = []

        el = 0 
        while el < self.length 
            arr_build = []
            sub_arr = 0 

            while sub_arr < self.length 
                arr_build << self[sub_arr][el]
                sub_arr += 1 
            end 

            transposed << arr_build 
            el += 1 
        end 

        transposed 
    end 


end 
