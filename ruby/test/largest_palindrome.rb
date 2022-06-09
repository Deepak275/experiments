def check_palindrome(subsstr)
  subsstr == subsstr.reverse
end


def largest_palindrome(str)
  current_longest = ''
  global_longest = ''

  for l in 0..(str.length - 1) do
    for r in l..(str.length - 1) do
      if check_palindrome(str[l..r])
        current_longest = str[l..r]
        if current_longest.length > global_longest.length
          global_longest = current_longest
        end
      end
    end
  end

  global_longest
end

p largest_palindrome('sfgadag')