# Method 3 ( O(n^2) time and O(1) extra space )
# This method is based on method 1. We know that ith entry in a line number line is
# Binomial Coefficient C(line, i) and all lines start with value 1. The idea is to 
# calculate C(line, i) using C(line, i-1). It can be calculated in O(1) time using the
# following.

# C(line, i)   = line! / ( (line-i)! * i! )
# C(line, i-1) = line! / ( (line - i + 1)! * (i-1)! )
# We can derive following expression from above two expressions.
# C(line, i) = C(line, i-1) * (line - i + 1) / i


def name(n)
  return [1] if n == 0
  line = 1
  fin = []


  while line <= n
    ar = []
    c = 1
    i = 1
    
    while i <= line
      ar << c
      c = c * (line - i)/i

      i += 1
    end
    fin << ar
    # p c

    line += 1
  end

  return fin
  # for(int line = 1; line <= n; line++) 
  #   { 
          
  #   int C=1;// used to represent C(line, i) 
  #   for(int i = 1; i <= line; i++) 
  #   {  
  #       // The first value in a line is always 1 
  #       System.out.print(C+" "); 
  #       C = C * (line - i) / i;  
  #   } 
  #   System.out.println(); 
  #   } 
end

p name(5)