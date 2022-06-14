require 'byebug'

class MaxIntSet
  attr_reader :store 

  def initialize(max)     
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num >= store.length
    @store[num] = true 
  end

  def remove(num)
    @store[num] = false 
  end

  def include?(num)
    @store[num] == true
  end
end


class IntSet
  attr_reader :store 

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = get_bucket(num)
    store[bucket] << num unless store[bucket].include?(num)
  end

  def remove(num)
    bucket = get_bucket(num)
    store[bucket].delete(num)
  end

  def include?(num)
    bucket = get_bucket(num)
    store[bucket].include?(num)
  end

  private

  def [](num)
    #store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def get_bucket(num)
    num % num_buckets
  end 
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
