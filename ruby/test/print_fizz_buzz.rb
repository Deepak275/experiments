def print_fizzbuzz
  for i in 1..100 do
    if i % 5 == 0 && i % 3 == 0 
      p "FizzBuzz"
    elsif i % 5 == 0
      p "Buzz"
    elsif i % 3 == 0
      p "Fizz"
    else
      p i
    end
  end
end

print_fizzbuzz