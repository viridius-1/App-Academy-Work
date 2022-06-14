#this is a LRU Cache implemented with an array 
class LRUCache
   
   attr_reader :lru_ct
   attr_accessor :lru_cache

   def initialize(n)
      @lru_cache = Array.new(n)
      @lru_ct = 0 
   end

   def count
      lru_cache.length 
   end

   def add(el)
      delete_lru_el if cache_length_is_4_and_no_els_are_nil

      if lru_cache_has_el?(el)
         add_el_to_cache(el)
      elsif lru_cache.include?(nil)
         replace_nil_idx_with_el(el)
      else      
         add_el_to_cache(el)
      end 
   end

   def show
      cache = []
      lru_cache.each { |el| cache << el[0] }
      p cache
   end

   private

   def increment_lru_ct 
      @lru_ct += 1 
   end 

   def add_el_to_cache(el)
      increment_lru_ct
      lru_cache.push([el, lru_ct])
   end 

   def delete_el_from_cache(el)
      lru_cache.delete(el) 
   end 

   def delete_index_from_cache(idx)
      lru_cache.delete_at(idx) 
   end 

   def replace_nil_idx_with_el(el)
      lru_cache.each_with_index do |cache_el, idx|  
         if cache_el == nil 
            delete_index_from_cache(idx)
            add_el_to_cache(el)
            break 
         end 
      end 
   end 

   def delete_lru_el
      lru_el = nil 
      lru_el_ct = 0 

      lru_cache.each_with_index do |el, idx| 
         if lru_el == nil || el[1] < lru_el_ct 
            lru_el = el   
            lru_el_ct = el[1] 
         end 
      end 

      delete_el_from_cache(lru_el)
   end 
   
   def lru_cache_has_el?(el)
      lru_cache.each_with_index do |cache_el, idx| 
         next if cache_el == nil 
         if cache_el[0] == el
            delete_index_from_cache(idx)
            return true 
         end 
      end 

      false 
   end 

   def cache_length_is_4_and_no_els_are_nil
      count == 4 && !lru_cache.any? { |el| el == nil }
   end 

end

johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

johnny_cache.count # => returns 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})

johnny_cache.show


