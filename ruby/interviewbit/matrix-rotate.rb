# Time Complexity: O(n*n), where n is side of array.
# Space Complexity: O(1)


p a = [[1,2,3],[4,5,6],[7,8,9]]
N = a.length

for i in 0..(N/2-1) do
  for j in i..(N-i-2) do
    temp = 0

    temp = a[i][j]
  
    a[i][j] = a[N - 1 - j][i]

    a[N - 1 - j][i] = a[N - 1 - i][N - 1 - j]

    a[N - 1 - i][N - 1 - j] = a[j][N - 1 - i] 

    a[j][N - 1 - i] = temp
  end
end
p a