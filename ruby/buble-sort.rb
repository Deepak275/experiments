ar = [3,28,27, 4,9, 22]

ar_length = ar.length

for i in 0..(ar_length -1)
  for j in 0..(ar_length - i - 2)
    temp = 0
    if ar[j] > ar[j+1]
      temp = ar[j+1]
      ar[j+1] = ar[j]
      ar[j] = temp
    end
  end
end

p ar