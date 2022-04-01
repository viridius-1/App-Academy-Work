#method returns boolean of whether a number is prime 
def is_prime?(num)
    return false if num < 2 
    (2...num).each { |i| return false if num % i == 0}
    true 
end 

#method returns the nth prime 
def nth_prime(n)
    primes = []

    i = 2 
    until primes.length == n 
        primes << i if is_prime?(i)
        i += 1 
    end 

    primes[-1]
end 

#method returns a range of primes 
def prime_range(min, max)
    primes = []
    (min..max).each { |i| primes << i if is_prime?(i) }
    primes 
end 