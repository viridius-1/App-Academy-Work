require_relative 'min_max_stack'

def time(start_time)
    Time.now - start_time
end 

def print_time(start_time)
    puts "Finished in #{time(start_time)} seconds."
    puts "---------------------------------------"
end 

#class implements a queue by using the interface of the MyStack class. Time O(1), Space O(1).  
class MinMaxStackQueue
    attr_reader :s1, :s2

    def initialize
        @s1 = MinMaxStack.new 
        @s2 = MinMaxStack.new  
    end 

    def enqueue(el)
        @s1.push(el)
    end 

    #Time O(1), Space O(1)
    def dequeue 
        #pop all elements off @s1 and push them into @s2 
        until @s1.empty? 
            el = @s1.pop
            @s2.push(el)  
        end 

        #pop last element off @s2 
        @s2.pop 

        #pop all elements off @s2 and push them into @s1
        until @s2.empty? 
            el = @s2.pop
            @s1.push(el)  
        end  
    end 

    def max 
        @s1.max 
    end 

    def min 
        @s1.min 
    end 

    def size 
        @s1.size
    end 

    def empty? 
        @s1.empty?
    end 

end 

# start_time = Time.now 
# sq = MinMaxStackQueue.new 
# sq.enqueue(1)
# sq.enqueue(2)
# sq.enqueue(3)
# sq.enqueue(4)
# sq.enqueue(5)
# puts "Filled Queue = #{sq.s1.stack}"

# sq.dequeue 
# puts "Queue with 1 dequeue = #{sq.s1.stack}"

# sq.dequeue 
# puts "Queue with 2 dequeues = #{sq.s1.stack}"
# puts "Queue size with 2 dequeues = #{sq.size}"
# puts "Queue Empty = #{sq.empty?}"
# puts "Queue Max = #{sq.s1.max}"
# puts "Queue Min = #{sq.s1.min}"
# print_time(start_time)