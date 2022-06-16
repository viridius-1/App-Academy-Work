class Node

  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev_node = prev 
    next_node = @next 

    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail 

  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail 
    tail.prev = head 
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev 
  end

  def empty?
    head.next == tail 
  end

  def find(key)
    current_node = head 

    until current_node == tail 
      next_node = current_node.next 
      return next_node if next_node.key == key 
      current_node = current_node.next 
    end 

    nil 
  end

  def get(key)
    current_node = head 

    until current_node == tail 
      next_node = current_node.next 
      return next_node.val if next_node.key == key 
      current_node = next_node
    end 

    nil 
  end 

  def include?(key)
    return true if get(key)
    false 
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last_node = last 

    #operations to add the node to the end of the linked list 
    last_node.next = new_node

    new_node.prev = last_node
    new_node.next = tail 

    tail.prev = new_node 
  end

  def update(key, val)
    node = find(key)
    node.val = val if node 
  end

  def remove(key)
    node_to_remove = find(key)
    node_to_remove.remove 
  end

  def each(&prc)
    current_node = head 
    
    until current_node == tail 
      next_node = current_node.next
      prc.call(next_node) if next_node != tail 
      current_node = next_node
    end 
  end 

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end

