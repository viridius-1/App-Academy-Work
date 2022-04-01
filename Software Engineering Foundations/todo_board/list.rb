require_relative "item.rb"

class List 

    attr_accessor :label 

    def initialize(label)
        @label = label 
        @items = []
    end 

    def add_item(title, deadline, description='')
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            true 
        else   
            false 
        end 
    end 

    def size
        @items.length 
    end 

    def valid_index?(index)
        return true if index >= 0 && index < @items.length 
        false 
    end 

    def swap(idx1, idx2)
        if valid_index?(idx1) && valid_index?(idx2)
            @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
            true 
        else 
            false 
        end 
    end 

    def [](idx)
        return @items[idx] if @items[idx]
        nil 
    end 

    def priority
        @items.first 
    end 

    def print_list 
        puts "----------------------------------------"
        puts @label.rjust(21)
        puts "----------------------------------------"
        print "Index".ljust(12) + "| Item".ljust(14) + "| Deadline".ljust(20) + "| Done?\n"

        @items.each_with_index do |item, idx| 
            print "#{idx}".ljust(11) + " | #{item.title}".ljust(15) + "| #{item.deadline}".ljust(20) + "| #{item.done}\n"
        end 
        puts "----------------------------------------"
    end 

    def print_full_item(idx)
        puts "----------------------------------------"
        print "#{@items[idx].title}".ljust(25) + "#{@items[idx].deadline}\n"
        puts @items[idx].description 
        puts "Done = #{@items[idx].done}" 
        puts "----------------------------------------"
    end 

    def print_priority
        print_full_item(0)
    end 

    #method moves element at a specified index up in the array a specified amount of times. if no amount given then it moves 1 time. if item gets to the front then it stays there. 
    def up(idx, amt=1)
        if valid_index?(idx)
            swaps = 0 
            until swaps == amt 
                if idx == 0 
                    break 
                else 
                    @items[idx], @items[idx - 1] = @items[idx - 1], @items[idx]
                    idx -= 1 
                    swaps += 1 
                end 
            end 
            true 
        else 
            false 
        end 
    end 

    #method moves element at a specified index down in the array a specified amount of times. if no amount given then it moves 1 time. if item gets to the bottom then it stays there. 
    def down(idx, amt=1)
        if valid_index?(idx)
            swaps = 0 
            until swaps == amt 
                if idx == @items.length - 1  
                    break 
                else 
                    @items[idx], @items[idx + 1] = @items[idx + 1], @items[idx]
                    idx += 1 
                    swaps += 1 
                end 
            end 
            true 
        else 
            false 
        end 
    end 

    #method sorts items according to their deadline
    def sort_by_date! 
        @items.sort_by! { |item| item.deadline }
    end 

    def toggle_item(idx)
        @items[idx].toggle 
    end 

    def remove_item(idx)
        if valid_index?(idx)
            @items.delete_at(idx)
            true 
        else 
            false 
        end 
    end 

    #method removes all items currently marked as done 
    def purge 
        checkmark = "\u2713"
        removals = []
        @items.each_with_index { |item, idx| removals << item if item.done == [checkmark] }  
        removals.each { |item| @items.delete(item) }
    end 

end 

