p a = [5, 1, 3, 2, 4]




# def swap(n1, n2, a)
#   temp = a[n1]
#   a[n1] = a[n2]
#   a[n2] = temp
# end

# def wave(a)
#   i = 0
#   n = a.length

#   while i < n
#     if i > 0 && a[i] < a[i - 1]
#       swap(i, i-1, a)
#     end

#     if (i< (n - 1) && a[i] < a[i + 1])
#       swap(i, i+1, a)
#     end

#     i += 2
#   end 
  
#   p a
# end

def wave(a)
  a.sort!

  n = a.length
  i = 0

  while i < n-1
    temp = a[i]
    a[i] = a[i + 1]
    a[i + 1] = temp  

    i += 2
  end
  p a
end

wave(a)