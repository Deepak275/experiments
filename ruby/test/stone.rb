def remove_stone(s, n)
  stones = s.split('')
  prev = stones.first
  count = 0
  
  for i in (1..(n - 1))
  	if stones[i] == prev
      count = count + 1
    end

    prev = stones[i]
  end

  count
end  

p remove_stone('GRBGGRBRGRBGGBBBBBGGGBBBBRBRGBRRBRGBBBRBBRRGBGGGRB', 50)