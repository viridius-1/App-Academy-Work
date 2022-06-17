require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache

  attr_reader :map, :max, :prc, :store

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      val = store.get(key)
      store.remove(key)
    else 
      val = prc.call(key)
    end 
    @map[key] = store.append(key, val) #assign the key of the hash map to a corresponding node at the end of the doubly-linked list

    eject! if count > max 
    val 
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def eject!
    #remove node from Linked List 
    oldest_node_key = store.head.next.key
    store.remove(oldest_node_key)

    #remove key from hash map 
    map.delete(oldest_node_key)
  end

end
