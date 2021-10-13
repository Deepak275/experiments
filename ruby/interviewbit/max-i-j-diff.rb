# Time Complexity: O(n) 
# Auxiliary Space: O(n)
 

p a = [9, 2, 3, 18, 5, 6, 7, 8, 4, 0]
# [100, 100, 100, 100, 100]



def max(x, y)
  x > y ? x : y
end
 
def min(x, y)
  x < y ? x : y
end

def max_diff(a)
  
  n = a.length
  return 0 if n == 1

  i = 1

  rmax = Array.new(n)
  lmin = Array.new(n)

  lmin[0] = a[0]

  while i < n
    # p i, a[i]
    lmin[i] = [a[i], lmin[i - 1]].min
    i += 1
  end

  rmax[n - 1] = a[n - 1];
  j = n-2

  while j >=0
    
    rmax[j] = [a[j], rmax[j + 1]].max
    j -= 1
  end

  p lmin, rmax

  # /* Traverse both arrays from left to right to find optimum j - i
  #     This process is similar to merge() of MergeSort */
  i = 0
  j = 0
  maxDiff = -1

  while (j < n && i < n)
    if (lmin[i] <= rmax[j])
      maxDiff = max(maxDiff, j - i)
      p 'j'
      p j = j + 1
    else
      p 'i'
      p i = i + 1
    end
    # p i,j
  end

  maxDiff
end

p max_diff(a)