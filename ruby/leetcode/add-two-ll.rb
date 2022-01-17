class ListNode
    attr_accessor :val, :next
    def initialize(val = 0, _next = nil)
        @val = val
        @next = _next
    end
end


def add_two_numbers(l1, l2)
  curr = ListNode.new()
  res = curr
  l1_cur = l1
  l2_cur = l2
  carry = 0
  
  while(l1_cur != nil && l2_cur != nil)
    sum  = l1_cur.val + l2_cur.val + carry
    curr.next = ListNode.new(sum % 10);
    carry = sum / 10

    curr = curr.next
    l1_cur = l1_cur.next
    l2_cur = l2_cur.next
  end


  if(l1_cur == nil)
    while l2_cur != nil
      p sum = l2_cur.val + carry
      curr.next = ListNode.new(sum % 10);
      carry = sum / 10
      curr = curr.next
      l2_cur = l2_cur.next
    end
  end

  if(l2_cur == nil)
    while l1_cur != nil
      sum = l1_cur.val + carry
      curr.next = ListNode.new(sum % 10);
      carry = sum / 10
      curr = curr.next
      l1_cur = l1_cur.next
    end
  end

  curr.next = carry == 0 ? nil : ListNode.new(carry)

  res.next
end





# class Node
#   attr_accessor :next, :value
#   def initialize(value)
#     @value = value
#     @next  = nil
#   end
#   def to_s
#     "Node with value: #{@value}"
#   end
    
#   def append(val)
      
#     last_node = find_tail  
#     @value = value
#     @next = nil  
#   end  
    
#   def find_tail
#       node = self
#       return node if !self.next
#       return node if !self.next while node = node.next
#   end    
# end


# class LinkedList
#   def initialize
#     @head = nil
#   end
#   def append(value)
#     if @head
#       find_tail.next = Node.new(value)
#     else
#       @head = Node.new(value)
#     end
#   end
#   def find_tail
#     node = @head
#     return node if !node.next
#     return node if !node.next while (node = node.next)
#   end
# end