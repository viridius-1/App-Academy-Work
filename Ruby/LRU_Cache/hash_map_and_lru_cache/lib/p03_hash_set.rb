class HashSet

  attr_reader :count, :store 

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if resize_needed?
    bucket = get_bucket(key)
    unless self[bucket].include?(key)
      self[bucket] << key  
      @count += 1 
    end 
  end

  def include?(key)
    bucket = get_bucket(key)
    self[bucket].include?(key) 
  end

  def remove(key)
    bucket = get_bucket(key)
    @count -= 1 if store[bucket].delete(key)
  end

  private

  def [](num)
    store[num] 
  end

  def num_buckets
    @store.length
  end

  def get_bucket(key)
    key.hash % num_buckets
  end 

  def resize_needed? 
    count != 0 && count % 8 == 0 
  end 

  def resize!
    store_copy = store.dup 
    @store = Array.new(store.length * 2) { Array.new }

    store_copy.each do |old_bucket| 
      old_bucket.each do |key| 
        bucket = get_bucket(key)
        self[bucket] << key  
      end 
    end 
  end

end
