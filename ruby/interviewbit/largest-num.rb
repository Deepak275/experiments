def largest_num(a)
  # return 0 if a.join(',') == 0
  
  ans = []

  ans = a.map {|val| val.to_s}
  ans.sort! {|a,b| b+a <=> a+b }
  p ans

  ans.join('').sub!(/^[0:]*/,"")
end

p largest_num([3, 30, 34, 5, 9])