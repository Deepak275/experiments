related = ["1100", "1110", "0110", "0001"]

related_len = related.first.split('').length
twod_related = Array.new(related_len, 0) { Array.new(related_len, 0)}

for i in 0..(twod_related.length - 1) do
  p row = related[i].split('')
  for j in 0..(twod_related.length - 1) do
    twod_related[i][j] = row[j].to_i
  end
end

p twod_related




def calculate(related)
  releated_len = related.length
  
  ans = 0
  for j in 0..releated_len - 1 do
    for k in 0..releated_len - 1 do
      if(related[j][k] == 1)
        ans += solve(related, j,k)
      end
    end  
  end

  p ans
end

def solve(related, i, j)
  related[i][j] = 0
  releated_len = related.first.length

  if(i+1 < releated_len && related[i+1][j] ==1)
    solve(related, i+1, j)
  end


  if(i-1 >= 0 && related[i-1][j] ==1)
    solve(related, i-1, j)
  end

  if(j+1 < releated_len && related[i][j+1] ==1)
    solve(related, i, j+1)
  end

  if(j-1 >= 0 && related[i][j-1] ==1)
    solve(related, i, j-1)
  end


  if(i+1<releated_len && j+1<releated_len && related[i+1][j+1] == 1)
    solve(related,i+1,j+1);
  end
  
  if(i+1<releated_len && j-1>=0 && related[i+1][j-1] == 1)
    solve(related, i+1,j-1);
  end
  
  if(i-1>=0 && j+1<releated_len && related[i-1][j+1] == 1)

    solve(related, i-1,j+1);
  end
  
  if(i-1>=0 && j-1>=0 && related[i-1][j-1] == 1)
    solve(related, i-1,j-1);
  end
  
  1
end

calculate(twod_related)