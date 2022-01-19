# Simple Hello World print.
defmodule Task1 do
  def hello do
    :world
  end

  # Prints if inputted value is odd or even.
  def is_even(n) do
    if rem(n, 2) == 0 do
      IO.write(n)
      IO.puts(" is even")
    else
      IO.write(n)
      IO.puts(" is odd")
    end
  end

  # Sums all the values in an array recursively.
  def sum([], sum) do
    sum
  end
  def sum(list,sum) do
    [first_number | remaining_numbers] = list
    new_sum = sum + first_number
    sum(remaining_numbers, new_sum)
  end
end
