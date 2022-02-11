defmodule Task6 do

  def list1(num) do
    list = Enum.to_list(2..num)
    solution_one(list)
  end

  def list2(num) do
    list = Enum.to_list(2..num)
    primes = []
    solution_two(list, primes)
  end

  def list3(num) do
    list = Enum.to_list(2..num)
    primes = []
    Enum.reverse(solution_three(list,primes))
  end

  def solution_one(list) do
    [h | t] = list
    case t do
      [] ->
        list
      _ ->
        t = Enum.filter(t, fn(x) ->
          rem(x, h) != 0
        end)

        [h | solution_one(t)]
    end
  end

  def solution_two([h | t], primes) do
    if Enum.any?(primes, fn(x) -> rem(h,x) == 0 end) do
      solution_two(t,primes)
    else
      solution_two(t,primes ++ [h])
    end
  end

  def solution_three([],primes) do primes end
  def solution_three([h | t], primes) do
    if Enum.any?(primes, fn(x) -> rem(h,x) == 0 end) do
      solution_three(t,primes)
    else
      solution_three(t,[h | primes])
    end
  end


  def bench() do
    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024, 16*1024]

    time = fn (i, f) ->
      elem(:timer.tc(fn () -> f.(i) end),0)
    end

    bench = fn (i) ->
      solutionOne = fn(numbs) ->
       list1(numbs)
      end

      solutionTwo = fn(numbs) ->
        list2(numbs)
      end

      solutionThree = fn(numbs) ->
        list3(numbs)
      end

      timeOne = time.(i, solutionOne)
      timeTwo = time.(i, solutionTwo)
      timeThree = time.(i, solutionThree)

      IO.write("  #{timeOne}\t\t\t#{timeTwo}\t\t\t#{timeThree}\n")
    end

    IO.write("# benchmark of lists and tree \n")
    Enum.map(ls, bench)
    :ok
  end


end
