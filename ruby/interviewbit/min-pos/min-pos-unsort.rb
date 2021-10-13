p a = [ 1, 2, 3, 4, 5, 6 ]
# [ 1 ]
# [2, 3, 7, 6, 8, -1, -10, 15]


def find_missing_least(positive_array)
  return 1 if positive_array.empty?
  len = positive_array.length
  
  positive_array.each_with_index do |val, i|
    val = val.abs

    if val - 1 < len && positive_array[val-1] > 0
      positive_array[val-1] = -positive_array[val-1]
    end
  end

  positive_array.each_with_index do |val, i|
    if val > 0
      return i + 1
    end
  end

  return (len + 1)
end


def seggerated_postive(sorted_arr, size)
  postive_nums = []

  for value in sorted_arr do
    if value > 0
      postive_nums << value
    end
  end

  p postive_nums
end


size = a.length

positive_array = seggerated_postive(a, size)

p find_missing_least(positive_array)

