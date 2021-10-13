p a = [ 2, 5, 6, 8, 6, 1, 2, 9, 9 ]
inc = 07it83

# len = a.length
# last_digit = a[len - 1]


# if a[len-1] == 9
#   a[len -1] = 0
#   inc = 1

#   (len-2).downto(0) do |i|
#       if a[i] == 9 && inc
#         p 'coming'
#         a[i] = 0
#         inc = 1
#       else
#         p 'here'
#         a[i] = a[i] + 1
#         inc = 0
#         break
#       end
#   end  
# else
#   a[len -1] = a[len -1] + 1
# end  

# p a


length = a.length

a.unshift(0)

carry = 1

loop do
  p digit = a[length]

  if digit < 9
    a[length] += carry
    break
  else
    a[length] = 0
    
  end
  length -= 1
  p 'here'
end

a.shift while a[0] == 0
p a





  # index = a.size
  # p a.unshift(0)
  # p 
  # carry = 1
  # loop do
  #   # p "index: #{index}"
  #   p d = a[index]
  #   if d < 9
  #     a[index] += carry
  #     break
  #   else
  #     a[index] = 0
  #   end
  #   index -= 1
  # end
  # a.shift while a[0] == 0
  # p a