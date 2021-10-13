# https://www.interviewbit.com/problems/min-steps-in-infinite-grid/

# https://www.geeksforgeeks.org/minimum-steps-needed-to-cover-a-sequence-of-points-on-an-infinite-grid/
# Time Complexity: O(N)

# Hint: consider move in diagonal direction too :P 

ans = 0


for i in 0..(a.length -2) do
  x_diff = (a[i] - a[i+1]).abs 
  y_diff = (b[i] - b[i+1]).abs

  ans = x_diff > y_diff ? x_diff + ans : y_diff + ans
end

ans