defmodule Bench do

  def bench() do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> f.(seq) end),0)
    end

    bench = fn (i) ->

      list = fn (seq) ->
        List.foldr(seq, list_new(), fn (e, acc) -> list_insert(e, acc) end)
      end

       tree = fn (seq) ->
         List.foldr(seq, tree_new(), fn (e, acc) -> tree_insert(e, acc) end)
      end

      tl = time.(i, list)
      tt = time.(i, tree)

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree \n")
    Enum.map(ls, bench)

    :ok
  end

  def list_new() do l = [] end

  def list_insert(e, l) do
    case l do
      [] ->
        [e]

      [h | t] ->
        if e < h do
          [e | l]
        else
          [h | list_insert(e, t)]
        end
    end
  end


  def tree_new() do
    {:node, :nil}
  end

  def tree_insert(value, :nil) do
    {:leaf, value}
  end

  def tree_insert(value, {:leaf, v}) do
    cond do
      v < value -> {:node,v,:nil,{:leaf,value}}
      v > value -> {:node,v,{:leaf,value}, :nil}
    end
  end

  def tree_insert(value, {:node, :nil}) do
    {:node, value, {:leaf,:nil},{:leaf,:nil}}
  end

  def tree_insert(value, {:node, v, left, right}) do
    cond do
      value > v -> {:node,v,left,tree_insert(value,right)}
      value < v -> {:node,v,tree_insert(value,left),right}
    end
  end
end
