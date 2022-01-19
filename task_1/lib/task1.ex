defmodule Task1 do
  # ---------------------------------------------------------------

  # Simple Hello World print.
  def hello do
    :world
  end

  # ---------------------------------------------------------------

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

  # ---------------------------------------------------------------

  # Base case that handles when array has been iterated through
  def sum([], sum) do
    sum
  end

  # Main recursion loop, sums all values in an inputted array.
  def sum(list, sum) do
    [first_number | remaining_numbers] = list
    new_sum = sum + first_number
    sum(remaining_numbers, new_sum)
  end

  # ---------------------------------------------------------------

  # Handles special case where the entire list has been iterated through
  def largest([], largest_value) do
    largest_value
  end

  # Main recursion loop, compares head with the current largest value
  def largest(list, largest_value) do
    [head | tail] = list

    if head > largest_value do
      largest(tail, head)
    else
      largest(tail, largest_value)
    end
  end

  # ---------------------------------------------------------------

  # Multiplies m and n recursively.
  def product_case(m, n) do
    case m do
      0 ->
        m

      _ ->
        n + product_case(m - 1, n)
    end
  end

  # ---------------------------------------------------------------

  # Returns nth element in list
  def nth(n, l) do
    [head | tail] = l

    case n do
      1 ->
        head

      _ ->
        nth(n - 1, tail)
    end
  end

  # ---------------------------------------------------------------

  # Return the number of elements in the list l
  def len(l) do
    [_head | tail] = l

    case tail do
      [] ->
        1

      _ ->
        len(tail) + 1
    end
  end

  # ---------------------------------------------------------------

  # Inserts element x in array l
  def add(x, l) do
    [head | tail] = l
    cond do
      tail == [] ->
        [head, x]
      x == head ->
        l
      x != head ->
        [head | add(x, tail)]
    end
  end

end
