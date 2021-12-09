# p a = [ 2, 5, 6, 8, 6, 1, 2, 9, 9 ]
# inc = 07it83

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


# length = a.length

# a.unshift(0)

# carry = 1

# loop do
#   p digit = a[length]

#   if digit < 9
#     a[length] += carry
#     break
#   else
#     a[length] = 0
    
#   end
#   length -= 1
#   p 'here'
# end

# a.shift while a[0] == 0
# p a





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



#   def balancedSum(arr)
#     # Write your code here
#     len = arr.length
    
#     prefix_sum = []
#     suffix_sum = []
    
#     prefix_sum[0] = arr[0]
    
#     for i in 1..(len-1) do
#         prefix_sum[i] = prefix_sum[i - 1] + arr[i]
#     end
    
#     suffix_sum[len - 1] = arr[len - 1]
#     (len-2).downto(0) do |i|
#         suffix_sum[i] = suffix_sum[i + 1] + arr[i]
#     end
    
#     for i in 1..(len-1) do
#         if (prefix_sum[i] == suffix_sum[i])
#             return i
#         end    
#     end
    
#     return -1
# end

# p balancedSum([1, 2, 3, 4,6])


# def minPenalty(a)
#   # Write your code here
#   len = a.length
#   prime_nos = []
#   non_prime_nos = []
  
#   for i in 0..(len-1) do
#     if (a[i] == 1)
#       non_prime_nos.push(1)
#       next
#     end  
  
    
#     flag = 0
#     # for j  2..(a[i]/2 ) do
#     #   if (a[i] % j == 0)
#     #       flag = 1
#     #       break
#     #   end
#     # end

#     j = 2
#     while j < a[i]/2
#       if (a[i] % j == 0)
#         flag = 1
#         break
#       end
#       j = j + 1
#     end

#     if (flag == 1)
#       non_prime_nos.push(a[i])
#       next
#     end

#     prime_nos.push(a[i])
#   end    

#   p prime_nos
#   p non_prime_nos


#   non_prime_nos.sort.first
# end

# p minPenalty([3,7,1,4,6,6])


# def solution(a)
#   # write your code in Ruby 2.2
#   len = a.length
  
#   for i in 0..(len - 1) do
#     while (a[i] >= 1 && a[i] <= len && a[i] != a[a[i] - 1])
#       temp = a[a[i] - 1]
#       a[a[i] - 1] = a[i]
#       a[i] = temp
#     end
#   end

#   for i in 0..(len - 1) do
#     if (a[i] != i + 1)
#       return (1 + i)
#     end
#   end

#   return (len+1)
# end

# # p solution([−1,−3])
# p solution([2, 3, -7, 6, 8, 1, -10, 15])

require 'set'

def solution(s)
  # write your code in Ruby 2.2

  substring_set = Array.new
  len = s.length

  for i in 0..(len - 1) do
    freq = Array.new(26, 0)
    substr = ''

    for j in 0..(len - 1) do
      pos = s[j].ord - 'a'.ord

      if (freq[pos] == 1)
        p 'h'
        break
      end
      # p pos
      freq[pos] = 1

      substr = substr + s[j]
      p 'r'
      substring_set.push(substr)
    end
  end
  p substring_set.uniq
  return substring_set.size
end

p solution('dddd')
p solution('cycle')