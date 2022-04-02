require "byebug"

class PolyTreeNode 

    attr_accessor :children, :parent
    attr_reader :value 

    def initialize(value)
        @value = value 
        @parent = nil 
        @children = []
    end 

    def parent=(parent)
        @parent = parent
        parent.children << self if parent != nil && !parent.children.include?(self) 
    end 

    #method to customize rspec output 
    def inspect 
        value.inspect 
    end 

end 
