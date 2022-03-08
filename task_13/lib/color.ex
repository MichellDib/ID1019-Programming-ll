defmodule Color do
  def convert(depth,max) do
    f = (depth/max)
    a = f*4
    x = Kernel.trunc(a)
    y = Kernel.trunc(255*(a-x))
    case x do
      0 ->
        {:rgb, 0, 0, y}
      4 ->
        {:rgb, 255, 0, y}
      3 ->
        {:rgb,(255-y), 255, 0}
      2 ->
        {:rgb, 255, 0, y}
      1 ->
        {:rgb, y, 0, 255}
    end
  end
end
