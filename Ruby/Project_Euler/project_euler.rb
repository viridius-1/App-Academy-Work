#Problem 1 - method returns the sum of multiples of 3 or 5 below a number, n.
def mults_sum(n)
    sum = 0 
    (2...n).each { |i| sum += i if i % 3 == 0 || i % 5 == 0 } 
    sum 
end 

