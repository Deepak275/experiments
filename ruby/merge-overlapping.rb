# https://www.interviewbit.com/problems/merge-overlapping-intervals/
# https://www.geeksforgeeks.org/merging-intervals/

def merge_overlapping(arr)
  stack = []
  arr.sort!{|a, b| a[0] <=> b[0]}

  stack.push(arr.first)
  # arr.pop

  for i in 1..arr.length - 1 do
    interval = arr[i]
    top = stack.first

    if top.last < interval.first
      stack.push(interval)
    elsif top.last < interval.last
      top[1] = interval.last
      stack.pop
      stack.push(top)
    end
  end

  while !stack.empty?
    p stack.pop
  end
end


merge_overlapping([[1,3],[2,6],[8,10],[15,18]])
