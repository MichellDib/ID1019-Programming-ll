defmodule Moves do

  def state() do
    {[:a,:b],[:c, :d],[:e, :f]}
  end


  def single({:one, steps},{main, one, two}) do
    cond do
      steps > 0 ->
        l = length(main)

        new_main = ListMod.take(main, l-steps)
        move_train = ListMod.drop(main, l-steps)
        {new_main,ListMod.append(move_train, one),two}
      steps < 0 ->
            l = length(one)
            move_train = ListMod.take(one,-steps)
            new_main = ListMod.append(main, move_train)
            new_one = ListMod.drop(one,-steps)
            {new_main,new_one,two}
      steps == 0 ->
        {main,one,two}
      end
  end

  def single({:two, steps},{main, one, two}) do
    cond do
      steps > 0 ->
        l = length(main)
        new_main = ListMod.take(main, l-steps)
        move_train = ListMod.drop(main, l-steps)
        {new_main,ListMod.append(move_train, one),two}
      steps < 0 ->
            l = length(one)
            move_train = ListMod.take(one,-steps)
            new_main = ListMod.append(main, move_train)
            new_one = ListMod.drop(one,-steps)
            {new_main,new_one,two}
      steps == 0 ->
        {main,one,two}
      end
  end

  def move([], state) do state end
  def move([head | tail], state) do
    cond do
      tail == [] ->
        [state,single(head,state)]
      true ->
        [state | move(tail,single(head,state))]
    end
  end
end
