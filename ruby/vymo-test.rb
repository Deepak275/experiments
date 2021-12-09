# def print_occurence(a)
#   occurence = {}

#   for value in a do
#     if occurence.keys.include?(value)
#       occurence[value] = occurence[value] + 1
#     else
#       occurence[value] = 1
#     end
#   end

#   p occurence
# end
# print_occurence([3, 4, 6, 2, 6, 7, 1, 7, 8, 9, 0, 1, 4])

def print_smallest_largest(a)
  sorted_arry = a.sort
  p sorted_arry.first
  p sorted_arry.reverse!.first
end

print_smallest_largest([3, 4, 6, 2, 6, 7, 1, 7, 8, 9, 0, 1, 4])