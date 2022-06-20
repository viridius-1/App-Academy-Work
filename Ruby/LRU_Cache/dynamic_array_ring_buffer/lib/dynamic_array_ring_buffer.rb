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
      arr = array_with_start_idx_at_0
      arr[i]
    else 
      wrap_ct = get_wrap_ct
      arr = array_with_start_idx_outside_0(wrap_ct)
      arr[i] 
    end 
  end

  def []=(i, val)
    if i >= capacity 
      if start_idx == 0 
        arr = array_with_start_idx_at_0
        set_over_index_array(i, val, arr)
      else 
        wrap_ct = get_wrap_ct
        arr = array_with_start_idx_outside_0(wrap_ct)
        set_over_index_array(i, val, arr)
      end 
    end 

    if i < 0 
      real_i = count + i   
      increase_count if array_index_is_nil?(real_i)
      set_index_and_value(real_i, val)
    else
      increase_count if array_index_is_nil?(i)
      set_index_and_value(i, val)
    end 
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
    set_index_and_value(idx_for_push, val)
    increase_count
  end

  def unshift(val)
    resize! if count == capacity 
    increase_count
    @start_idx -= 1 
    @start_idx = start_idx % capacity 
    @store[start_idx] = val 
  end

  def pop
    decrease_count
    popped_el = store.store[count]
    @store.store[count] = nil 
    popped_el
  end

  def shift
    shifted_el = store.store[start_idx]
    @store.store[start_idx] = nil 

    decrease_count if shifted_el != nil 
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

  def set_over_index_array(i, val, arr)
    @store = StaticArray.new(arr.length)
    arr.each_with_index { |el, idx| @store.store[idx] = el }
    @store.store[i] = val 
  end 

  def set_index_and_value(idx, val)
    @store.store[idx] = val 
  end 

  def array_with_start_idx_at_0 
    store.store[0..count - 1]
  end 

  def array_with_start_idx_outside_0(wrap_ct)
    store.store[start_idx..start_idx + count] + store.store[0...wrap_ct]
  end

  def get_wrap_ct 
    (start_idx + count) % capacity
  end 

  def array_index_is_nil?(idx)
    store.store[idx] == nil 
  end 

  def increase_count
    @count += 1 
  end 

  def decrease_count 
    @count -= 1 
  end 

end



