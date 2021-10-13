
string = ARGV[0]
k = ARGV[1]

p string, k




def perfect_substr(string, k)
  freq = Array.new(10, 0)


  for index in 0..string.length do
    freq[string[index].to_i - 0] += 1
  end
  p 'first'
  p freq

  for i in 0..freq.length do
    if freq[i] != 0
      if freq[i] != k
        return 0
      end
    end
  end
  return 1
end


def perfect_stirng(string, k)
  ans = 0
  k = k.to_i

  input_str_length = string.length

  for index in 0..(input_str_length - k - 1) do
    j = k
    while j < input_str_length
      substring = string[index, j]
      ans += perfect_substr(substring, k)
      j += 1
    end
  end
  ans
end


p perfect_stirng(string, k)