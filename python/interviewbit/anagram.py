from collections import defaultdict

def are_anagrams(a):
  anagrams_dict = {}
  
  
  for x in a:
    temp = x
    sort_str = ''.join(sorted(x))
    
    value = anagrams_dict.get(sort_str)
    
    if not value:
      anagrams_dict[sort_str] = []
    anagrams_dict[sort_str].append(temp)
  
    # print(anagrams_dict)
  print(anagrams_dict)
    
are_anagrams(a = ["cat", "dog", "tac", "god", "act"])