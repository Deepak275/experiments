def minamx(a)
  ans = -Float::MAX.to_i
  min1 = Float::MAX.to_i
  min2 = Float::MAX.to_i
  max1 = -Float::MAX.to_i
  max2 = -Float::MAX.to_i
  for  i in 0..(a.count-1)
    min1 = [min1, (a[i] - i)].min
    min2 = [min2, (a[i] + i)].min
    max1 = [max1, (a[i] - i)].max
    max2 = [max2, (a[i] + i)].max
  end
  ans = [ans, max2 - min2].max
  ans = [ans, max1 - min1].max
  return ans
end

p minamx([ 1, 3, -1 ])



# diff = []
#   for j in 0..a.length - 1 do
# for i in 0..a.length - 1 do

#     next if i > j

#     val_diff = a[i] - a[j]
#     index_diff = i - j

#     val_diff = val_diff < 0 ? - val_diff : val_diff
#     index_diff = index_diff < 0 ? -index_diff : index_diff
#     diff << (val_diff + index_diff)
#   end  
# end

# diff.sort.last