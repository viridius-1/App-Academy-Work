class MinMaxStack 
    def initialize
        @store = []
        @max = nil 
        @min = nil 
    end 

    def push(el)
        @store << el 
        
        #evaluate max and min 
        @max = el if @max == nil || el > @max 
        @min = el if @min == nil || el < @min
    end 

    def pop
        @store.pop 
    end 

    def peek 
        @store[-1]
    end 

    def stack 
        @store 
    end  

    def max 
        @max 
    end 

    def min 
        @min 
    end 

    def size 
        @store.length 
    end 

    def empty? 
        @store.empty? 
    end 
end 
