defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog this is a sample text that we will use when we build up a table we will only handle lower case letters and no punctuation symbols the frequency will of course not represent english but it is probably not that far off'
  end

  def text() do
    'cheesecake'
  end

  def test do
    sample = text()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    IO.inspect(encode)
    text = text()
    seq = encode(text, encode)
    IO.inspect(decode)
    decode = Enum.to_list(decode)
    IO.inspect(decode)
    List.to_string(decode(seq, decode))
  end

  def tree(sample) do
    freq = Map.to_list(freq(sample))
    freq = freq |> Enum.sort_by(&elem(&1, 1))
    IO.inspect(huffman(freq))
  end

  def freq(sample) do
    freq(sample, %{})
  end

  def freq([], freq) do
    freq
  end

  def freq([char | rest], freq) do
    case Map.get(freq, [char]) do
      nil -> freq(rest, Map.put(freq, [char], 1))
      value -> freq(rest, Map.put(freq, [char], value + 1))
    end
  end

  def huffman([{key1, val1}, {key2, val2}]) do
    {{key1, key2}, val1 + val2}
  end

  def huffman([{key1, val1}, {key2, val2} | rest]) do
    huffman(join({{key1, key2}, val1 + val2}, rest))
  end

  def join({k1, v1}, [{k2, v2}]) do
    cond do
      v1 <= v2 ->
        [{k1, v1}, {k2, v2}]

      true ->
        [{k2, v2}] ++ [{k1, v1}]
    end
  end

  def join({key1, val1}, [{key2, val2} | rest]) do
    cond do
      val1 <= val2 ->
        [{key1, val1}, {key2, val2}] ++ rest

      true ->
        [{key2, val2}] ++ join({key1, val1}, rest)
    end
  end


  # def find_path({left, right}, table, path) do
  #   table = find_path(left, table, path ++ [0])
  #   find_path(right, table, path ++ [1])
  # end

  # def find_path(key, table, path) do
  #   Map.put(table, key, path)
  # end

  def encode([], table) do
    []
  end

  def encode(text = [head | tail], table) do
    Map.fetch!(table, [head]) ++ encode(tail, table)
  end



  # def decode([], _) do [] end
  # def decode(seq, tree) do
  #   {char, rest} = decode_char(seq, 1, tree)
  #   [char | decode(rest, tree)]
  # end

  # def decode_char(seq, n, table) do
  #   {code, rest} = Enum.split(seq, n)
  #   case List.keyfind(table, code, 1) do
  #     {char, _} ->
  #       {char, rest}
  #     nil ->
  #       decode_char(seq, n + 1, table)
  #   end
  # end

  def decode([], _) do
    []
  end

  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)

    case Map.get(table, code) do
      nil ->
        decode_char(seq, n+1, table)
      _ ->
        {Map.get(table,code),rest}
    end
  end

  def decode_table({tree, freq}) do
    decode_table(tree, %{}, [])
  end

  def decode_table({left, right}, table, path) do
    table = decode_table(left, table, path ++ [0])
    decode_table(right, table, path ++ [1])
  end

  def decode_table(k, table, path) do
    Map.put(table, path, k)
  end

  def encode(text, table) do
    # To implement...
  end

  def decode(seq, tree) do
    # To implement...
  end

  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)
    length = byte_size(binary)

    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, rest} ->
        {list, length - byte_size(rest)}

      list ->
        {list, length}
    end
  end

  def bench() do
    sample = sample()
    {text, length} = read("data.txt")
    {tree, tree_time} = time(fn -> tree(text) end)
    {encode_table, encode_table_time} = time(fn -> encode_table(tree) end)
    {decode_table, decode_table_time} = time(fn -> decode_table(tree) end)
    {encode, encode_time} = time(fn -> encode(text, encode_table) end)
    {_, decoded_time} = time(fn -> decode(encode, decode_table) end)

    e = div(length(encode), 8)
    r = Float.round(e / length, 3)

    IO.puts("Tree Build Time: #{tree_time} us")
    IO.puts("Encode Table Time: #{encode_table_time} us")
    IO.puts("Decode Table Time: #{decode_table_time} us")
    IO.puts("Encode Time: #{encode_time} us")
    IO.puts("Decode Time: #{decoded_time} us")
    IO.puts("Compression Ratio: #{r}")
  end

  def time(func) do
    {func.(), elem(:timer.tc(fn -> func.() end), 0)}
  end
end
