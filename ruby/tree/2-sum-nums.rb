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

    def find_pair_with_sum(root, target)
      curr1 = root
      curr2 = root

      s1 =[]
      s2 =[]

      done1 = false
      done2 = false

      val1 = 0
      val2 = 0


      while true
        while(!done1)
          if !curr1.nil?
            p curr1.value
            s1.push(curr1)
            curr1 = curr1.left
          else
            if s1.empty?
              done1 = true
            else
              curr1 = s1.pop
              val1 = curr1.value
              curr1 = curr1.right
              done1 = true
            end  
          end
        end

        while(!done2)
          if !curr2.nil?
            s2.push(curr2)
            curr2 = curr2.right
          else
            if s2.empty?
              done2 = true
            else
              curr2 = s2.pop
              val2 = curr2.value
              curr2 = curr2.left
              done2 = true
            end  
          end
        end

        if val1 != val2 && ((val1 + val2) == target)
          p "pair found: #{val1}, #{val2}"
          return 1
        end  
        
        if (val1 + val2) < target
          done1 = false
        end
        
        if (val1 + val2) > target
          done2 = false
        end  
          
        
        if val1 >= val2
          return 0
        end
      end
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

# 7 10 9 20 -1 -1 -1 -1

t.insert(7)
t.insert(10)
t.insert(9)
t.insert(20)
t.insert(-1)
t.insert(-1)
t.insert(-1)
t.insert(-1)


# t.insert(4)
# t.insert(6)
# t.insert(8)
# t.insert(3)
# t.insert(1)
# t.insert(-1)


p t.inspect
p t.find_pair_with_sum(t, 19)