ans =0 


nimeshika_array = [40,20,60]

ans = 0  
for i in 1..(songs.length - 1) do
    for j in 0..(i-1) do
        if (songs[i] + songs[j]) % 60 == 0
        ans += 1
        end
    end
end

ans

p ans
return ans








