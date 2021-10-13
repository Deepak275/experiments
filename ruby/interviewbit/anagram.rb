#https://www.geeksforgeeks.org/check-whether-two-strings-are-anagram-of-each-other/



a = ["cat", "dog", "tac", "god", "act"]

words_hash = Hash.new{|h,k| h[k] = []}

for val in a do
  sort_word = val.chars.sort.join

  words_hash[sort_word].push(val)
end

p words_hash
  # words_hash.each {|key, val| p val}