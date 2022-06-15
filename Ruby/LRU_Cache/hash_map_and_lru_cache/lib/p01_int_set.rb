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
    self[bucket] << num unless self[bucket].include?(num)
  end

  def remove(num)
    bucket = get_bucket(num)
    self[bucket].delete(num)
  end

  def include?(num)
    bucket = get_bucket(num)
    self[bucket].include?(num)
  end

  private

  def [](num)
    store[num]
  end

  def num_buckets
    @store.length
  end

  def get_bucket(num)
    num % num_buckets
  end 
end

class ResizingIntSet
  attr_reader :count, :store 

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if resize_needed? 
    bucket = get_bucket(num)
    unless self[bucket].include?(num)
      self[bucket] << num 
      @count += 1 
    end 
  end

  def remove(num)
    bucket = get_bucket(num)
    @count -= 1 if store[bucket].delete(num)
  end

  def include?(num)
    bucket = get_bucket(num)
    self[bucket].include?(num) 
  end

  private

  def [](num)
    store[num]
  end

  def num_buckets
    @store.length
  end

  def get_bucket(num)
    num % num_buckets
  end 

  def resize_needed?
    count != 0 && count % 20 == 0 
  end 

  def resize!
    store_copy = store.dup 
    @store = Array.new(store.length * 2) { Array.new }

    store_copy.each do |old_bucket| 
      old_bucket.each do |el| 
        bucket = get_bucket(el)
        self[bucket] << el 
      end 
    end 
  end
end
