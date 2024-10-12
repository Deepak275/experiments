# Time Complexity: O(nlogn) based on sort algo.
# As the whole array is needed to be traversed only once.
# Auxiliary Space: O(n). 
# As a hash map has been used to store array elements.

require 'set'

# a = [1, 4, 45, 6, 10, -8]
a = [11, 4, 17, -1, 5]
sum = 16



#Most effiecient solution


p 'sdfdsa'
def pair_sum(a, sum)
  l = 0
  r = a.length - 1

  p a.sort!
  
  while l < r
    print l,r
    p '\n'
    if (a[r] + a[l] == sum)
      p "pair are #{l} #{r}"
      l = l + 1
    elsif (a[r] + a[l] < sum)
      l = l + 1
    else
      r = r - 1
    end
  end
end

p pair_sum(a, sum)







sum_hash = Set.new
for i in 0..a.length-1 do
  temp = sum - a[i]
  if sum_hash.include?(temp)
    p "element #{a[i]} and #{temp} gives the desired sum: #{sum}"
  end
  sum_hash.add(a[i])
end


# Time Complexity: O(nlogn) based on sort algo. 
# As the whole array is needed to be traversed only once.
# Auxiliary Space: O(n). 