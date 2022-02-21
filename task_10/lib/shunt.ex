defmodule Shunt do
  def find(_, []) do [] end
  def find(xs, ys) do
    cond do
      xs == ys ->
        []
      true ->
        [y | yt] = ys
        {hs, ts} = split(xs, y)

        moves = [
          {:one, 1 + Enum.count(ts)},
          {:two, Enum.count(hs)},
          {:one, -(1 + Enum.count(ts))},
          {:two, -(Enum.count(hs))}
        ]

        moves ++ find(ts ++ hs, yt)
    end
  end

  def few(_,[]) do [] end
  def few(xs, ys) do
    cond do
      xs == ys ->
        []
      true ->
        [y | yt] = ys
        {hs, ts} = split(xs, y)

        moves = [
          {:one, 1 + Enum.count(ts)},
          {:two, Enum.count(hs)},
          {:one, -(1 + Enum.count(ts))},
          {:two, -Enum.count(hs)}
        ]
        if Enum.count(hs) == 0 do
          [] ++ few(ts,yt)
        else
          moves ++ few(ts ++ hs, yt)
        end
    end
  end



  def split(train, n) do
    pos = ListMod.position(train, n)

    case pos do
      1 ->
        {[], ListMod.drop(train, pos)}

      _ ->
        {ListMod.take(train, pos - 1), ListMod.drop(train, pos)}
    end
  end

  def compress(ms) do
    ns = rules(ms)
    cond do
      ns == ms -> ms
      true -> compress(ns)
    end
  end

  #def rules([_,0]) do [] end
  def rules([]) do [] end
  def rules([a]) do
    {t,n} = a
    cond do
      n == 0 -> []
      true -> [a]
    end
  end
  def rules([a,b|t]) do
    {a_tail, a_n} = a
    {b_tail, b_n} = b
    cond do
      a_tail == :one and b_tail == :one ->
        rules([{:one,a_n+b_n}|t])
      a_tail == :two and b_tail == :two ->
        rules([{:two,a_n+b_n}|t])
      a_n == 0 ->
        rules([b|t])
      true ->
        [a] ++ rules([b|t])
    end
  end

end
