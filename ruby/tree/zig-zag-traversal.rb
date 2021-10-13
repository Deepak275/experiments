class Node
  attr_accessor :data, :left, :right
  
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end


class Tree
  attr_accessor :root

  def initialize()
    @root = Node.new(2) 
  end


  def create
    current_node = nil
    p "Enter the no of elements"
    # total_elements = gets.chomp
    p "Enter the root node element"
    # p data = gets.chomp
    # @root.data = data

    @root.left = Node.new(2);
    @root.right = Node.new(3);
    @root.left.left = Node.new(7);
    @root.left.right = Node.new(6);
    @root.right.left = Node.new(5);
    @root.right.right = Node.new(4);

    #2
  end

  def zig_zag_traverse()

    return if root == nil
    
    curr = []
    next_level = []
    temp = nil
    ltor = true

    curr << @root
    while !curr.empty?
      temp = curr.pop
      # p "here"

      if !temp.nil?
        p temp.data
        
        if ltor
          next_level << temp.left if !temp.left.nil?
          next_level << temp.right if !temp.right.nil?
        else
          next_level << temp.right if !temp.right.nil?
          next_level << temp.left if !temp.left.nil?
        end
      end

      if curr.empty?
        ltor = !ltor
        temp_stack = []
        temp_stack = next_level
        next_level = curr
        curr = temp_stack
      end  
    end
    
    
    
    # curr << @root
    # ltor = true

    # temp = curr.pop

    # if ltor
      
    # else
    #   curr << temp.right
    #   curr << temp.left
    # end
  end
end

t = Tree.new
t.create
t.zig_zag_traverse