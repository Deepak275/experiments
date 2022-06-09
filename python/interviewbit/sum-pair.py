from packaging import print_function


def sum_pair(a, sum):

  r = len(a) - 1
  l = 0

  # print(l)
  # print(r)
  a.sort()

  while (l < r):
    print(l,r)
    if sum < (a[r] + a[l]):
      r -= 1
    elif sum > (a[r] + a[l]):
      l += 1
    else:
      print("the pairs are: ", a[r], a[l]) 
      break 
      
sum_pair([1, 5, 7, 9, 3], 6)
