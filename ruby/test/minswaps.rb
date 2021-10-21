
# def min_swaps(arr)
#   len = arr.length
#   no_of_zeroes = Array.new(len)
#   count = 0

#   no_of_zeroes[len - 1] = 1 - arr[len - 1]

#   (len-2).downto(0) do |i|
#     no_of_zeroes[i] = no_of_zeroes[i+1]
#     if arr[i] == 0
#       no_of_zeroes[i] = 1 + no_of_zeroes[i] if no_of_zeroes[i].nil?
#       no_of_zeroes[i] = no_of_zeroes[i] + 1
#     end

#   end

#   for i in 0..len-1 do
#     if arr[i] == 1
#       count += no_of_zeroes[i]
#     end
#   end

#   count
# end

def sorted_already?(arr)
  len = arr.length
  if (arr[0] == 1 && arr[len - 1] == 0) || (arr[0] == 0 && arr[len - 1] == 1)
       return true
  end     
  return false
end

def min_swaps(arr)
  len = arr.length
  return 0 if sorted_already?(arr)
    
    count = 0
    no_unplaced_zeroes = 0
    
    (len - 1).downto(0) do |i|
        if arr[i] == 0
            no_unplaced_zeroes += 1
        else
            count += no_unplaced_zeroes
        end
    end    
    count
end

p min_swaps([1,1,1,1,0,1,0,1])