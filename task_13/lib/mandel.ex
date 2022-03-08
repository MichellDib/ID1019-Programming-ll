defmodule Mandel do
  def mandelbrot(width, height, x, y, k, max) do
    trans = fn w, h ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    all_rows(width, height, trans, max, [])
  end

  def all_rows(width, height, trans, max, list) do
    case height do
      0 ->
        list
      _ ->
        row = rows(width, height, trans, max, [])
        all_rows(width, height - 1, trans, max, [row | list])
    end
  end

  def rows(width, height, trans, max, row) do
    case width do
      0 ->
        row
      _ ->
        depth = Brot.mandelbrot(trans.(width,height), max)
        color = Color.convert(depth, max)
        row = [color | row]
        rows(width - 1, height, trans, max, row)
    end
  end
end
