require "byebug"

class PolyTreeNode 

    attr_accessor :children, :parent
    attr_reader :value 

    def initialize(value)
        @value = value 
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

    #method to customize rspec output 
    def inspect 
        value.inspect 
    end 

end 
