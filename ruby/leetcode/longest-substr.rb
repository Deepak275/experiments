def longest_substr(str)
  test_str = ''
  max_len = -1;
  
  return 0  if str.empty?
  return 1  if str.length == 1

  for value in str.split('') do
    p test_str
    if test_str.include?(value)
      test_str[test_str.index(value)+1, test_str.length - 1]
    end

    test_str = test_str + value

    max_len = [max_len, test_str.length].max
  end
  return max_len
end

p longest_substr('geeksforgeeks')