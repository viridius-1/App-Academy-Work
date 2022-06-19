require 'byebug'

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count, :start_idx, :store 

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    if start_idx == 0 
      arr = store.store[0..count - 1]
      arr[i]
    else 
      wrap_ct = (start_idx + count) % capacity
      arr = store.store[start_idx..start_idx + count] + store.store[0...wrap_ct]
      arr[i] 
    end 
  end

  def []=(i, val)
    @store.store[i] = val 
  end

  def capacity
    store.length 
  end

  def include?(val)
    store.store.include?(val)
  end

  def push(val) 
    resize! if count == capacity 
    idx_for_push = (start_idx + count) % capacity 
    @store.store[idx_for_push] = val 
    @count += 1 
  end

  def unshift(val)
    resize! if count == capacity 
    @count += 1 
    @start_idx -= 1 
    @start_idx = start_idx % capacity 
    @store[start_idx] = val 
  end

  def pop
    @count -= 1
    popped_el = store.store[count]
    @store.store[count] = nil 
    popped_el
  end

  def shift
    shifted_el = store.store[start_idx]
    @store.store[start_idx] = nil 

    @count -= 1 
    @start_idx += 1 

    shifted_el
  end

  def first
    if start_idx == 0 
      store.store[0]
    else 
      store.store[start_idx]
    end 
  end

  def last
    if start_idx == 0 
      store.store[count - 1]
    else 
      store.store[start_idx - 1]
    end  
  end

  def each(&prc)
    store.store.each { |el| prc.call(el) }  
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    #get the spaceship operator value of comparing the 2 arrays 
    if other.class == Array 
      spaceship_evaluation = store.store.length <=> other.length 
    else 
      spaceship_evaluation = store.store.length <=> other.store.store.length 
    end 

    #determine the smaller array length of the 2 arrays 
    if spaceship_evaluation == 1 || spaceship_evaluation == 0 
      if other.class == Array 
        min_arr_length = other.length 
      else 
        min_arr_length = other.store.store.length 
      end 
    else 
      min_arr_length = store.store.length 
    end 

    #compare the equality of the 2 arrays 
    if other.class == Array 
      store.store[0..min_arr_length - 1] == other[0..min_arr_length - 1] 
    else
      store.store[0..min_arr_length - 1] == other.store.store[0..min_arr_length - 1]
    end 
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    @count = 0 
    @start_idx = 0 
    store_copy = store.store.dup 
    @store = StaticArray.new(capacity * 2)
    store_copy.each { |el| push(el) }   
  end

end

