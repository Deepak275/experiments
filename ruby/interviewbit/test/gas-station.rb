def get_start_city(total_cities, gas, gas_required)
  tank = 0
  gas_diff = 0
  start = 0
  total = 0

  gas.each_with_index do |val, i|
    gas_diff = val - gas_required[i]
    total += gas_diff
    tank += gas_diff

    if tank < 0
      start = i
      gas_diff = 0
      tank = 0
    end
  end

  if total >= 0
    return start + 1
  end

  return -1
end

p get_start_city(7, [1,2,3,4,5,1, 10], [3,4,5,1,2,10, 1])