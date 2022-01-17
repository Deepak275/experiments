def no_of_presentation(arrival, duration)
  temp = []
  
  for value in (0..(arrival.length)-1) do
    if value == 0
      temp.push(arrival.first + duration.first)
      next
    end

    if temp.last <= arrival[value] &&  arrival[value] != arrival[value - 1]
      temp.push(arrival[value] + duration[value])
    end

    # p value
  end

  p temp.length
end

arrival = [1,3,35,7]
# arrival = [1, 3, 3, 5, 7]
duration = [2, 2, 1, 2, 1]
no_of_presentation(arrival, duration)