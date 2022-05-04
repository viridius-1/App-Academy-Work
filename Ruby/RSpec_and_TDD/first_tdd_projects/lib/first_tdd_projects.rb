#method removes repeated elements in an array
def my_uniq(arr) 
    uniq_els = []
    arr.each { |el| uniq_els << el unless uniq_els.include?(el) }
    uniq_els
end 

class Array 
    #method returns the positions in an array that sum to 0. puts positions with smaller indices before larger indices. 
    def two_sum
        positions_that_sum_to_0 = []
    
        0.upto(self.length - 2) do |idx1| 
            (idx1 + 1).upto(self.length - 1) do |idx2| 
                if self[idx1] + self[idx2] == 0 
                    positions_that_sum_to_0 << [idx1, idx2]
                end 
            end  
        end 

        positions_that_sum_to_0 
    end  
end 

#method returns boolean of whether argument is a 2D array 
def two_d_array?(arr)
    return false unless arr.is_a?(Array)
    arr.each { |el| return false unless el.is_a?(Array) }
    true 
end 

#method transposes a 2D array of rows to the corresponding 2D array of columns 
def my_transpose(rows)
    raise "not a 2D array" unless two_d_array?(rows)
    col_arr = []

    col_idx = 0 
    while col_idx < rows.length 
        column = []

        row_idx = 0 
        while row_idx < rows.length 
            column << rows[row_idx][col_idx]
            row_idx += 1 
        end 

        col_arr << column
        col_idx += 1 
    end 

    col_arr
end 

def profit(sell_price, buy_price)
    sell_price - buy_price
end 

#method returns the days to trade a stock to make the largest profit 
def trade_stock(buy_day, sell_day, largest_profit)
    return [buy_day, sell_day] if largest_profit
    []
end 

#method returns the days to buy and sell a stock in order to make the most profit. returns days in array format. 
def stock_picker(prices)
    buy_day = nil 
    sell_day = nil 
    largest_profit = nil 

    idx1 = 0 
    while idx1 < prices.length - 1 
        potential_buy_day = prices[idx1]

        idx2 = idx1 + 1 
        while idx2 < prices.length 
            potential_sell_day = prices[idx2]
            if potential_sell_day <= potential_buy_day
                idx2 += 1 
                next 
            end 
            if largest_profit == nil || profit(potential_sell_day, potential_buy_day) > largest_profit 
                buy_day = idx1 
                sell_day = idx2 
                largest_profit = profit(potential_sell_day, potential_buy_day)
            end 
            idx2 += 1 
        end 

        idx1 += 1 
    end 

    trade_stock(buy_day, sell_day, largest_profit)
end 

#Towers of Hanoi Game 
class TowersOfHanoi

    attr_accessor :tower1, :tower2, :tower3, :user_move_from_tower

    def initialize
        @tower1 = [8, 7, 6, 5, 4, 3, 2, 1]
        @tower2 = []
        @tower3 = []
        @entry_description = nil 
        @user_move_from_tower = nil 
        @user_move_to_tower = nil 
        @disk_to_be_moved = nil 
        @disk_at_tower_to_be_moved_to = nil 
        @tower_hash = { 1 => tower1, 2 => tower2, 3 => tower3 }
        #introduction 
    end 

    def introduction 
        puts "Welcome to the Towers of Hanoi!"
        puts "Read about the game at https://en.wikipedia.org/wiki/Tower_of_Hanoi"
        puts "You win when you move all the disks to Tower 2 or Tower 3."
        puts "The disks are numbered by size."
        puts "A disk can't be placed on a disk that is smaller than it."
        puts "Good luck!"
        puts "\n"
        puts "Press return/enter to begin."
        gets 
        play 
    end 

    def play 
        until won? 
            clear 
            print_towers 
            user_move
        end 
        win
    end 

    def user_entry
        valid_entry = false 
        while !valid_entry 
            puts "Enter a tower to #{entry_description}. Enter 1, 2, or 3."
            user_move_from_tower = gets.chomp.to_i 
            if valid_entry?(user_move_from_tower)
                valid_entry = true 
            else 
                puts "Please enter 1, 2, or 3."
            end 
        end 
        user_move_from_tower
    end 

    #private 

    attr_reader :disk_to_be_moved, :disk_at_tower_to_be_moved_to, :entry_description, :tower_hash, :user_move_from_tower, :user_move_to_tower

    def tower_empty?(tower)
        tower_hash[tower].empty?
    end 

    def disk_at_tower(tower)
        tower_hash[tower][-1]
    end 

    def valid_move? 
        tower_empty?(user_move_to_tower) || disk_to_be_moved <= disk_at_tower_to_be_moved_to
    end 

    def valid_entry?(tower)
        [1, 2, 3].include?(tower)
    end 

    def user_move 
        user_move_from_tower = get_user_move_from_tower 
        user_move_to_tower = get_user_move_to_tower 
        move_disk(user_move_from_tower, user_move_to_tower)
    end 

    #method moves a disk from towerA to towerB
    def move_disk(towerA, towerB)
        unless tower_empty?(towerB)
            raise "A disk can't be put on a smaller disk." if disk_at_tower(towerA) > disk_at_tower(towerB)
        end 

        disk = tower_hash[towerA].pop
        tower_hash[towerB] << disk 
    end 

    def get_user_move_to_tower
        @disk_to_be_moved = disk_at_tower(user_move_from_tower)
        @entry_description = "move disk #{disk_to_be_moved} to"

        valid_move_to_tower = false 
        while !valid_move_to_tower
            @user_move_to_tower = user_entry
            @disk_at_tower_to_be_moved_to = disk_at_tower(user_move_to_tower)
            if valid_move?
                valid_move_to_tower = true 
            else 
                puts "Disk #{disk_to_be_moved} can't be moved to Tower #{user_move_to_tower}, because disk #{disk_to_be_moved} is larger than disk #{disk_at_tower_to_be_moved_to}." 
            end 
        end 

        user_move_to_tower
    end 

    def get_user_move_from_tower
        @entry_description = 'move from'

        valid_move_from_tower = false 
        while !valid_move_from_tower
            @user_move_from_tower = user_entry
            if tower_empty?(user_move_from_tower)  
                puts "Tower #{user_move_from_tower} is empty. Please select a tower that has a disk."
            else 
                valid_move_from_tower = true 
            end 
        end 

        user_move_from_tower
    end 

    def win 
        clear 
        print_towers
        puts "Congratulations! You won the Towers of Hanoi!"
    end 

    def won? 
        return true if tower2 == [8, 7, 6, 5, 4, 3, 2, 1] || tower3 == [8, 7, 6, 5, 4, 3, 2, 1]
        false 
    end 

    def get_longest_tower
        longest_tower = nil 
        tower_hash.values.each { |tower| longest_tower = tower if longest_tower == nil || tower.length > longest_tower.length } 
        longest_tower
    end 

    def empty_space?(tower, idx)
        tower[idx] == nil 
    end 

    def print_towers
        longest_tower = get_longest_tower

        puts "Towers of Hanoi".rjust(28)
        idx = longest_tower.length - 1
        while idx >= 0
            if empty_space?(tower1, idx) && empty_space?(tower2, idx)
                puts "#{tower1[idx]}                  #{tower2[idx]}                 #{tower3[idx]}"
            elsif empty_space?(tower1, idx)
                puts "#{tower1[idx]}                   #{tower2[idx]}               #{tower3[idx]}"
            elsif empty_space?(tower1, idx) && empty_space?(tower3, idx)
                puts "#{tower1[idx]}                   #{tower2[idx]}               #{tower3[idx]}"
            elsif empty_space?(tower2, idx)
                puts "#{tower1[idx]}                  #{tower2[idx]}                #{tower3[idx]}"
            else 
                puts "#{tower1[idx]}                  #{tower2[idx]}               #{tower3[idx]}"
            end 
            idx -= 1 
        end 
        puts "Tower 1         Tower 2         Tower 3"
    end 

    def clear 
        system("clear")
    end     

end 