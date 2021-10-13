module BinaryTree
  class Node
    # our three features:
    attr_reader :value
    attr_accessor :left, :right

    def initialize(v)
      @value = v
    end

    def insert(v)
      case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false # the value is already present
      end
    end

    def inspect
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    def search(root,key)
        # Base Cases: root is null or key is present at root 
        if root == nil || root.value == key 
          return root 
        end
        # Key is greater than root's key
        if root.value < key 
          return search(root.right,key) 
        end
        # Key is smaller than root's key 
        return search(root.left,key)
    end

    def height(root)
      return 0 if root == nil

      return 1 + [height(root.left), height(root.right)].max
    end 

    private

    def insert_left(v)
      if left
        left.insert(v)
      else
        self.left = Node.new(v)
      end
    end

    def insert_right(v)
      if right
        right.insert(v)
      else
        self.right = Node.new(v)
      end
    end
  end
end