a = ["cat", "dog", "tac", "god", "act"]

found = []
ans = []

len = a.length

for i in 0..(len-1) do
  word = a[i]

  sorted_word = word.chars.sort.join

  if !(found.include?(sorted_word))
    ans << a[i]
    found << sorted_word
  end
end

ans.sort

for value in ans do
  puts value
end