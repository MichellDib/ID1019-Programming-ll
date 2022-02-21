defmodule ListMod do
  def take(_,0) do [] end
  def take([head,_],1) do [head] end
  def take([],_) do [] end
  def take([head | tail],n) do
        [head|take(tail,n-1)]
  end

  def drop([head|tail],0) do [head|tail] end
  def drop([],_) do [] end
  def drop([head|tail], n) do
        drop(tail,n-1)
  end

  def append(list1,list2) do
    list1 ++ list2
  end

  def member([head | tail], x) do
    cond do
      x == head ->
        true
      tail == [] ->
        false
      true ->
        member(tail,x)
    end
  end

  def position([head|tail],x) do
    cond do
      x == head -> 1
      true -> position(tail,x)+1
    end
  end

end
