class PolyTreeNode 

    attr_accessor :children, :parent
    attr_reader :position 

    def initialize(position)
        @position = position 
        @parent = nil 
        @children = []
    end 

    def node_has_parent?
        if self.parent 
            true 
        else 
            false 
        end 
    end 

    def parent_has_child?(parent, child)
        parent.children.include?(child) 
    end 

    def delete_node_from_old_parent(node) 
        node.parent.children.delete(node)
    end 

    def parent=(new_parent)
        delete_node_from_old_parent(self) if node_has_parent?  
        @parent = new_parent
        new_parent.children << self if new_parent != nil && !parent_has_child?(new_parent, self)
    end 

    def add_child(child)
        child.parent = self 
    end 

    def remove_child(child)
        raise "This node is not a child." unless child.parent 
        child.parent = nil 
    end 

    #method does a depth-first search for a target node 
    def dfs(target)
        return self if position == target 
        children.each do |child| 
            search_result = child.dfs(target) 
            return search_result unless search_result.nil? 
        end 
        nil 
    end 

    #method does a breadth-first search for a target node 
    def bfs(target)
        queue = [self]
        until queue.empty? 
            node = queue.shift 
            return node if node.position == target 
            node.children.each { |child| queue << child }
        end 
        nil 
    end 

    #method to customize rspec output 
    def inspect 
        position.inspect 
    end 

end 
