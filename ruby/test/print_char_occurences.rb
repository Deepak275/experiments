def print_ascending(char_hash)
  ordered_chars = char_hash.keys

  for key in ordered_chars.sort! do
    p "key: #{key}, value :#{char_hash[key]}"
  end
end

def print_char_counts(str)
  char_hash = {}

  for value in str.chars do
    if char_hash[value].nil?
      char_hash[value] = 1
      next
    end

    char_hash[value] += 1 
  end
  char_hash

  print_ascending(char_hash)
end

p print_char_counts('Deepak@111')