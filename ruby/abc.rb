def total_qualified(k, scores)
  rank = Array.new(scores.length, 0)
  sorted_scores = scores.sort.reverse

  for i in 0..(scores.length - 1) do

    # rank[i] = 1 && next if (i == 0)

    if (i == 0)
      rank[i] = 1
      next
    end
    
    p i
    if (sorted_scores[i] == sorted_scores[i -1])
      rank[i] = rank[i-1]
    else
      rank[i] = rank[i-1] + 1
    end  
  end

  p rank
  # p rank.select{|i| i <= k }
  rank.select{|i| i <= k }.length
end

scores = [20, 30, 50, 50, 30, 40]

p total_qualified(3, scores)