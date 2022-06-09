def longest_substr(str)
  test_str = ''
  max_len = -1;
  
  return 0  if str.empty?
  return 1  if str.length == 1

  for value in str.split('') do
    if test_str.include?(value)
      test_str[test_str.index(value)+1, test_str.length - 1]
    end
    p test_str

    test_str = test_str + value

    max_len = [max_len, test_str.length].max
  end
  return max_len
end

p longest_substr('geeksforgeeks')



def longest_subst(str)
  substr = ''
  max_len_substr = ''

  return 0 if substr.empty?
  return 1 if substr.length == 1

  str.chars.each do |c|
    if substr.include?(c)
      substr[substr.indexOf(c) + 1, substr.length - 1]
    end

    substr = substr + c

    max_len = [max_len, substr.length].max
  end

  return max_len
end