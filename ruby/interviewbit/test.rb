# ["3", "30", "34", "5", "9"].sort! do |a,b|
#   print a,b + "\n"
#   b+a <=> a + b
# end



# a = [3,6,8]

# def cd(a)
#   a[1] = 1
# end

# def ab(a)
#   a[1] = 7
#   p a
#   cd(a)
# end
# p a
# ab(a)

# p a

# p 'here'

# for value in 6.downto(1) do
#   puts value
# end



# str = ['cat', 'dog', 'tac']

# anagram_hash = Hash.new {|h,k| h[k] = []}

# for value in str do
#   sorted_str = value.chars.sort.join
#   anagram_hash[sorted_str].push(value)
# end

# p anagram_hash.values


# require 'set'

# sum = 6

# a = [2,5,1,9,7]

# temp_hash = Set.new

# for value in a do
#   diff = sum - value
#   if temp_hash.include?(diff)
#     p "the nos are #{diff}, #{value}"
#     break
#   end
#   temp_hash.add(value)
# end


# a =  [ 97, 0, -461, -125, -404, -59, -322, -495, -288, -341, -449, -313, -192, -214, -389, -202, -183, -72, -416, -455, -187, -242, -416, 39, -198, -338, -465, -248, -25, -398, -97, -461, -214, -423, -407, -77, -190, -67, -178, -410, -160, 72, -350, -31, -85, -247, -319, -462, -303, -48, -354, -110, 17, 60, 19, 80, -218, -28, -426, -366, -140, 50 ]

# max_current=a.first
# max_global=a.first

# max_current = max_current < 0 ? 0 : max_current

# for val in a do
#   max_global = [max_global, max_current + val].max

#   max_current = max_current < 0 ? 0 : max_current
# end

# p max_global


# a = ["cat", "dog", "tac", "god", "act"]

# sorted_hash = Hash.new {|k, v| k[v] = []}

# a.each do |val|
#   sort_value = val.split('').sort.join
#   sorted_hash[sort_value] << val
# end

# p sorted_hash



# a = []
# carry = 1

# len = a.length

# if a[len - 1] == 9
#   a[len - 1] = 0
#   carry = 1

#   (len - 2).downto(0) do |i|
#     if a[i] == 9
#       a[i] = 0
#       carry = 1
#     else
#       a[i] = a[i] + 1
#       break
#     end  
#   end
# else
#   a[len - 1] = a[len - 1] + 1
# end

# a.shift while a[0] == 0

# p a


# a = [ 247, 240, 303, 9, 304, 105, 44, 204, 291, 26, 242, 2, 358, 264, 176, 289, 196, 329, 189, 102, 45, 111, 115, 339, 74, 200, 34, 201, 215, 173, 107, 141, 71, 125, 6, 241, 275, 88, 91, 58, 171, 346, 219, 238, 246, 10, 118, 163, 287, 179, 123, 348, 283, 313, 226, 324, 203, 323, 28, 251, 69, 311, 330, 316, 320, 312, 50, 157, 342, 12, 253, 180, 112, 90, 16, 288, 213, 273, 57, 243, 42, 168, 55, 144, 131, 38, 317, 194, 355, 254, 202, 351, 62, 80, 134, 321, 31, 127, 232, 67, 22, 124, 271, 231, 162, 172, 52, 228, 87, 174, 307, 36, 148, 302, 198, 24, 338, 276, 327, 150, 110, 188, 309, 354, 190, 265, 3, 108, 218, 164, 145, 285, 99, 60, 286, 103, 119, 29, 75, 212, 290, 301, 151, 17, 147, 94, 138, 272, 279, 222, 315, 116, 262, 1, 334, 41, 54, 208, 139, 332, 89, 18, 233, 268, 7, 214, 20, 46, 326, 298, 101, 47, 236, 216, 359, 161, 350, 5, 49, 122, 345, 269, 73, 76, 221, 280, 322, 149, 318, 135, 234, 82, 120, 335, 98, 274, 182, 129, 106, 248, 64, 121, 258, 113, 349, 167, 192, 356, 51, 166, 77, 297, 39, 305, 260, 14, 63, 165, 85, 224, 19, 27, 177, 344, 33, 259, 292, 100, 43, 314, 170, 97, 4, 78, 310, 61, 328, 199, 255, 159, 185, 261, 229, 11, 295, 353, 186, 325, 79, 142, 223, 211, 152, 266, 48, 347, 21, 169, 65, 140, 83, 156, 340, 56, 220, 130, 117, 143, 277, 235, 59, 205, 153, 352, 300, 114, 84, 183, 333, 230, 197, 336, 244, 195, 37, 23, 206, 86, 15, 187, 181, 308, 109, 293, 128, 66, 270, 209, 158, 32, 25, 227, 191, 35, 40, 13, 175, 146, 299, 207, 217, 281, 30, 357, 184, 133, 245, 284, 343, 53, 210, 306, 136, 132, 239, 155, 73, 193, 278, 257, 126, 331, 294, 250, 252, 263, 92, 267, 282, 72, 95, 337, 154, 319, 341, 70, 81, 68, 160, 8, 249, 96, 104, 137, 256, 93, 178, 296, 225, 237 ]

# len = a.length
# occurence = Array.new(len, 0)

# for value in a do
#   if occurence[value] >= 1
#     p value
#     break
#   end
#   occurence[value] += 1
# end



# for i in 10..1 do
#   puts "we are happy and we will get whatever we want :) " 
# end

a = [11, 4, 17, -1, 5]
sum = 16

l = 0
r = a.length - 1


while l < r
 if a[l] + a [r] == sum
  p l,r
  l = l + 1
 elsif a[l] + a [r] < sum
   l = l + 1
 else
  r = r - 1
 end
end