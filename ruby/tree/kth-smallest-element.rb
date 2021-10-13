module BinaryTree
  class Node
    # our three features:
    attr_accessor :value, :left, :right

    @@start = @@middle = @@last = @@prev = nil


    def initialize(v)
      @value = v
      @count = 0
    end
    
    def correctBSTUtil(root) 
        if( root != nil ) 
            # // Recur for the left subtree 
            correctBSTUtil( root.left)
  
            # // If this node is smaller than 
            # // the previous node, it's  
            # // violating the BST rule. 
            if (@@prev != nil && root.value < @@prev.value) 
                # // If this is first violation, 
                # // mark these two nodes as 
                # // 'first' and 'middle' 
                if (@@first == nil)
                    @@first = @@prev 
                    @@middle = root
                # // If this is second violation, 
                # // mark this node as last 
                else
                    @@last = root
                end    
            end
  
            # // Mark this node as previous 
            @@prev = root; 
  
            # // Recur for the right subtree 
            correctBSTUtil(root.right)
        end
    end
    
    def recoverTree(root)
        @@first = @@middle = @@last = @@prev = nil; 
  
        # // Set the poiters to find out  
        # // two nodes 
        correctBSTUtil(root); 
        p @@first, @@last
        # // Fix (or correct) the tree 
        if(@@first != nil && @@last != nil)
            return @@first.value, @@last.value
        # // Adjacent nodes swapped 
        elsif(@@first != nil && @@middle != nil)
            return @@first.value, @@middle.value
        end
    end

    def insert(v)
      case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false # the value is already present
      end
    end

    def inspect
      # p @@prev  
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    def kthSmallest(root, k)
        return nil if (root == nil) 
          
        left = kthSmallest(root.left, k); 
      
        return left if (left != nil) 

        @count += 1
        return root if (@count == k) 

        return kthSmallest(root.right, k); 
    end

    def post
      
    end

    def disoreder_bst(root)
      temp = root.left.value
      root.left.value = root.value
      root.value = temp
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

t = BinaryTree::Node.new(2)

t.insert(4)
t.insert(6)
t.insert(8)
t.insert(3)
t.insert(1)
t.insert(-1)

# p t.kthSmallest(t, 2)
p t.inspect
p t.disoreder_bst(t)
p t.inspect
p t.recoverTree(t)