#use of internet is not allowed

# use any language

#find no of pairs(two numbers) which give sum of 16

array = [11, 4, 17, -1, 5]

sum = 16

def find_sum_pair(arr, sum)
  pair = 0
  comp_arr = []

  arr.each do |val|
    diff = sum - val
    if comp_arr.include?(diff)
      pair = pair + 1
      p "pair are #{val}, #{diff}"
    end

    comp_arr.push(val)
  end
  
  pair
end

p find_sum_pair(array, sum)


