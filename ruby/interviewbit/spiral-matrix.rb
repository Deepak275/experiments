# Time Complexity: O(m*n).
# Space Complexity: O(1). 

n = 4
@count = 1
@result = Array.new(n){Array.new(n)}


def spiral_matrix(i, j, m, n)
  return if(i >= m || j >= n)

  #print first row
  for value in i..(n-1) do
    # puts @count
    @result[j][value] = @count
    @count += 1
  end


  # print last column

  for value in (i+1)..(m-1) do
    # puts @count
    @result[value][n-1] = @count
    @count += 1
  end

  if (m-1)!= i
    for value in (n-2).downto(j) do
      # puts @count
      @result[n-1][value] = @count
      @count += 1
    end
  end

  if (n-1)!= j
    for value in (m-2).downto(i+1) do
      # puts @count
      @result[value][i] = @count
      @count += 1
    end
  end

  spiral_matrix(i+1, j+1, m-1, n-1)
end

spiral_matrix(0, 0, n, n)

p @result
