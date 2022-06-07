class MyStack 
    def initialize
        @store = []
    end 

    def push(el)
        @store << el 
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

    def sum 
        @store.sum 
    end 

    def size 
        @store.length 
    end 

    def empty? 
        @store.empty? 
    end 
end 