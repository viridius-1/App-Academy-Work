require 'rspec'
require 'lru_cache'

describe LRUCache do 
   subject(:johnny_cache) { LRUCache.new(4) }

   describe '#initialize' do 
      it 'sets an initial cache of length 4' do 
         expect(johnny_cache.lru_cache.length).to eq(4)
      end 
   end 

   describe '#add' do 
      it 'adds an element to the cache' do 
         johnny_cache.add("I walk the line")
         expect(johnny_cache.lru_cache).to eq([nil, nil, nil, ["I walk the line", 1]])
      end 

      it 'moves an element to the end of the cache if it is already in the cache and is added a 2nd time' do 
         johnny_cache.add("I walk the line")
         johnny_cache.add(5)
         johnny_cache.add([1,2,3])
         johnny_cache.add(5)

         expect(johnny_cache.lru_cache).to eq([nil, ["I walk the line", 1], [[1, 2, 3], 3], [5, 4]])
      end 

      it 'returns the correct output after a series of cache adds' do 
         johnny_cache.add("I walk the line")
         johnny_cache.add(5)
         johnny_cache.add([1,2,3])
         johnny_cache.add(5)
         johnny_cache.add(-5)
         johnny_cache.add({a: 1, b: 2, c: 3})
         johnny_cache.add([1,2,3,4])
         johnny_cache.add("I walk the line")
         johnny_cache.add(:ring_of_fire)
         johnny_cache.add("I walk the line")
         johnny_cache.add({a: 1, b: 2, c: 3})

         expect(johnny_cache.lru_cache).to eq([[[1, 2, 3, 4], 7], [:ring_of_fire, 9], ["I walk the line", 10], [{:a=>1, :b=>2, :c=>3}, 11]])
      end 
   end 

   describe '#show' do 
      it 'prints the correct output after a series of cache adds' do 
         johnny_cache.add("I walk the line")
         johnny_cache.add(5)
         johnny_cache.add([1,2,3])
         johnny_cache.add(5)
         johnny_cache.add(-5)
         johnny_cache.add({a: 1, b: 2, c: 3})
         johnny_cache.add([1,2,3,4])
         johnny_cache.add("I walk the line")
         johnny_cache.add(:ring_of_fire)
         johnny_cache.add("I walk the line")
         johnny_cache.add({a: 1, b: 2, c: 3})

         expect(johnny_cache.show).to eq([[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}])
      end 
   end 

end 