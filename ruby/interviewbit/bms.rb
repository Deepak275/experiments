a = [10,1,2,3,4,5,6,7,8,9,10]

# len = a.length
# temp = Array.new(len, 0)
# ans = 0

# for i in 0..len - 1 do
#     # p i, a[i], temp[a[i]] if a[i] == 73
#     p a[i]
#     if temp[a[i] -1] >= 1
#         ans += 1
#     end
#     temp[a[i] - 1] += 1
    
# end

# p ans


# a = []
# sum = 0

# for value in a do
#   sum += value
# end

# p sum


temp = {}

for value in a do
  temp[value] = 0 and next if temp[value].nil?

  temp[value] += 1
end

p temp.values.select{|val| val >= 2}.count

