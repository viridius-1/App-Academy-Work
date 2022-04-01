class Stack 

    attr_accessor :cat_food

    def initialize 
        @cat_food = []
    end 

    def push(food)
        cat_food << food 
    end 

    def pop 
        cat_food.pop 
    end 

    def peek 
        cat_food[-1]
    end 

end 


class Queue

    attr_accessor :people 

    def initialize 
        @people = []
    end 

    def enqueue(el)
        people << el 
    end 

    def dequeue 
        people.shift  
    end 

    def peek 
        people[0]
    end 

end 

