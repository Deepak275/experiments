def left_rotation(s, d):
  return s[d:] + s[:d]

def right_rotation(s, d):
  return left_rotation(s, d)

def string_rotation(s, d):
  n = len(s)
  print(left_rotation(s, d))
  print(right_rotation(s, n - d))


string_rotation('GeeksforGeeks', 2)