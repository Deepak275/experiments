# int odd_l=0,odd_r=0,even_l=0,even_r=0;
#     int count=0,n=A.size();
#     for(int i=0;i<n;i++)odd_r+=(i%2)?A[i]:0,even_r+=(!(i%2))?A[i]:0;
#     for(int i=0;i<n;i++){
#         if(i%2)odd_r-=A[i];
#         else even_r-=A[i];
#         if(odd_l+even_r==odd_r+even_l)count++;
#         odd_l+=(i%2)?A[i]:0;
#         even_l+=(!(i%2))?A[i]:0;
#     }
#     return count;

def balance_array(a)
  # len = a.length
  odd_l=0
  odd_r=0
  even_l=0
  even_r=0
  count = 0

  a.each_with_index do |val, i|
    odd_r += ((i%2 != 0) ? val : 0)
    even_r += ((i%2 == 0) ? val : 0)
  end
  p 'first'
  p odd_r
  p even_r

  a.each_with_index do |val, i|
    p 'in'
    p odd_r
    p even_r
    p odd_l
    p even_l
    
    if (i%2 != 0)
      odd_r -= val
    else
      even_r -= val
    end

    if(odd_l + even_r == odd_r + even_l)
      p 'final'
      p odd_l, even_r
      p odd_r, even_l
      count += 1
      p 'end'
    end

    p odd_r
    p even_r
    odd_l += (i%2 != 0) ? val : 0
    even_l += (i%2 == 0) ? val : 0
  end
  

  count
end

p balance_array([5, 5, 2, 5, 8])
# p balance_array([8,4,3,5,2,1])

