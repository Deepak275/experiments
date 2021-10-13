# Time Complexity: O(n). 
# As the whole array is needed to be traversed only once.
# Auxiliary Space: O(n). 
# As a hash map has been used to store array elements.

require 'set'

a = [1, 4, 45, 6, 10, -8]
sum = 2

sum_hash = Set.new
for i in 0..a.length-1 do
  temp = sum - a[i]
  if sum_hash.include?(temp)
    p "element #{a[i]} and #{temp} gives the desired sum: #{sum}"
    return
  end
  sum_hash.add(a[i])
end