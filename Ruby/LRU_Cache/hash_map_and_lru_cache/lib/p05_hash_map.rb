require_relative 'p04_linked_list'

class HashMap
  
  include Enumerable

  attr_accessor :count, :linked_hash_map, :store 

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @linked_hash_map = LinkedList.new 
    @count = 0
  end

  def include?(key)
    bucket, linked_list = get_bucket_and_linked_list(key)
    return true if linked_list.find(key)
    false 
  end

  def set(key, val)
    resize! if resize_needed?
    bucket, linked_list = get_bucket_and_linked_list(key)

    if include?(key) 
      node = linked_list.find(key)
      node.val = val 
      linked_hash_map.update(key, val)
    else 
      linked_list.append(key, val)
      @count += 1 
      linked_hash_map.append(key, val)
    end 
  end

  def get(key)
    bucket, linked_list = get_bucket_and_linked_list(key)
    linked_list.get(key)
  end

  def delete(key)
    bucket, linked_list = get_bucket_and_linked_list(key)
    linked_list.remove(key)
    @count -= 1 
  end

  def each(&prc)
    store.each do |linked_list| 
      linked_list.each { |node| prc.call(node.key, node.val) } 
    end 
  end

  def print_insertion_order 
    linked_hash_map.each { |node| puts "Key - #{node.key}, Value - #{node.val}" } 
  end 

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize_needed? 
    count != 0 && count % 8 == 0 
  end 

  def resize!
    store_copy = store.dup 
    @store = Array.new(store.length * 2) { LinkedList.new }
    @count = 0 

    store_copy.each do |old_linked_list| 
      old_linked_list.each { |node| set(node.key, node.val) } 
    end 
  end

  def bucket(key)
    key.hash % num_buckets
  end

  def get_bucket_and_linked_list(key)
    bucket = bucket(key)
    linked_list = store[bucket]
    [bucket, linked_list]
  end 

end
