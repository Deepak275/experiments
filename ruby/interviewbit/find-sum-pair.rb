a = [3,4,6,7]
sum = 10

require 'set'

def find_pair(a, sum)
  temp = Set.new

  a.each do |val|
    diff = sum - val

    if temp.include?(diff)
      return true
    end
    
    temp << (val)
  end

  return false
end

p find_pair(a, sum)


## for returning indices

def two_sum(nums, target)
  temp = {}
  
  nums.each_with_index do |val, i|
      diff = target - val
      unless temp[diff].nil?
        return i, temp[diff]
      end
      
      temp[val] = i
  end  
end