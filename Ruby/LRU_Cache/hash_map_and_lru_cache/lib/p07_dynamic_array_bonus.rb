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

  attr_accessor :count, :store 

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    delete_nil_from_array if i < 0 
    store.store[i]
  end

  def []=(i, val)
    @store.store[i] = val 
  end

  def capacity
    @store.length
  end

  def include?(val)
    store.store.include?(val)
  end

  def push(val)
    resize! unless store.store.include?(nil)
    @store.store[count] = val 
    @count += 1 
  end

  def unshift(val)
    @store.store.unshift(val)
  end

  def pop
    delete_nil_from_array
    @count -= 1 
    store.store.pop
  end

  def shift
    @count -= 1 if count > 0 
    shifted_el = store.store.shift
    store.store << nil 
    shifted_el
  end

  def first
    store.store[0]
  end

  def last
    delete_nil_from_array
    store.store[-1]
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

  def delete_nil_from_array 
    @store.store.delete(nil)
  end 

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    @count = 0 
    store_copy = store.store.dup 
    @store = StaticArray.new(capacity * 2)
    store_copy.each { |el| push(el) }  
  end

end
