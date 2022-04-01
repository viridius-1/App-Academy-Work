#method prints the first n primes 
def primes(n)
    prm_nums = []
    i = 2 
    until prm_nums.length == n 
        prm_nums << i if prime?(i) 
        i += 1 
    end 
    prm_nums 
end 

#method returns boolean of whether a number is prime 
def prime?(num)
    (2...num).each { |i| return false if num % i == 0 }
    true 
end 

