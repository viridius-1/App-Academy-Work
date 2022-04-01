require_relative "list.rb"
require "byebug"

class TodoBoard

    def initialize
        @board = {}
    end 

    def get_command 
        print "Enter a command: "
        cmd, *args = gets.chomp.split
         
        case cmd 
        when 'mklist'
            @board[args.first] = List.new(args.first)
        when 'ls'
            @board.each_key { |list_label| puts list_label } 
        when 'showall'
            @board.each_value { |list_instance| list_instance.print_list } 
        when 'mktodo'
            @board[args.first].add_item(*args[1..-1])
        when 'up'
            nums = args[1..-1].map { |i| i.to_i }
            @board[args.first].up(*nums)
        when 'down'
            nums = args[1..-1].map { |i| i.to_i }
            @board[args.first].down(*nums)
        when 'swap'
            nums = args[1..-1].map { |i| i.to_i }
            @board[args.first].swap(*nums) 
        when 'sort'
            @board[args.first].sort_by_date!
        when 'priority'
            @board[args.first].print_priority
        when 'toggle'
            @board[args.first].toggle_item(args.last.to_i)
        when 'rm'
            @board[args.first].remove_item(args.last.to_i)
        when 'purge'
            @board[args.first].purge
        when 'print' 
            if args[1] == nil 
                @board[args.first].print_list
            else 
                @board[args.first].print_full_item(args.last.to_i) 
            end 
        when 'quit'
            return false 
        else 
            print "Sorry, that command is not recognized.\n"
        end 

        true 
    end 

    def run 
        ended = false 
        while !ended 
            ended = true unless get_command
        end 
    end 

end 

b = TodoBoard.new
b.run 