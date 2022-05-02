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

        idx1 = 0 
        while idx1 < self.length - 1 
            num1 = self[idx1]

            idx2 = idx1 + 1 
            while idx2 < self.length 
                num2 = self[idx2]
                positions_that_sum_to_0 << [idx1, idx2] if num1 + num2 == 0 
                idx2 += 1 
            end 

            idx1 += 1 
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