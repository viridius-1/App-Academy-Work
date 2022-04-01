#method returns the smallest amount of coins to give any change. works for any coins. solves recursively. 
def make_better_change(change, coins=[25, 10, 5, 1], result=[], best_solution=nil)
    #return no change if change is less than smallest coin 
    return [] if change < coins.min || change.is_a?(Float)

    #return coin if change is exactly equal to a coin 
    coins.each { |coin| return [coin] if coin == change } 

    coins.each do |coin| 
        if coin < change 
            result << coin 
            break 
        end 
    end 
    
    change_remaining = change - result.sum 
    coins_remaining = coins.select { |coin| coin <= change_remaining }

  
    change_result = (result + make_better_change(change_remaining, coins_remaining))
    debugger 
    if best_solution == nil 
        best_solution = change_result 
    elsif change_result.all? { |coin| coin == 1 }
        return best_solution 
    elsif change_result.length < best_solution.length 
        best_solution = change_result 
        result_start = get_result_start(change_result, coins) 
        make_better_change(change_remaining, coins, result_start, best_solution)
    else 
        result_start = get_result_start(change_result, coins) 
        make_better_change(change_remaining, coins, result_start, best_solution)
    end 
    
end 