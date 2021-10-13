def solve(a)
    h = a.length
    split_arr = a.each_slice(h/2+1).to_a

    first_half = split_arr.first
    second_half = split_arr.last
    
    first_max = first_half.max
    first_min = first_half.min
    
    second_max = second_half.max
    second_min = second_half.min

    global_max = first_max > second_max ? first_max : second_max
    global_min = first_min > second_min ? second_min : first_min

    global_max + global_min
end

p solve( [ -2, 1, -4, 5, 3 ])