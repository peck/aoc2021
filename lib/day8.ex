defmodule Aoc2021.Day8 do
  #This is wrong, different for each line...
  @segment_map %{
    0 => MapSet.new([:c, :a, :g, :e, :d, :b]),
    1 => MapSet.new([:a, :b]),
    2 => MapSet.new([:g, :c, :d, :f, :a]),
    3 => MapSet.new([:f, :b, :c, :a, :d]),
    4 => MapSet.new([:e, :a, :f, :b]),
    5 => MapSet.new([:c, :d, :f, :b, :e]),
    6 => MapSet.new([:c, :d, :f, :g, :e, :b]),
    7 => MapSet.new([:d, :a, :b]),
    8 => MapSet.new([:a, :c, :e, :d, :g, :f, :b]),
    9 => MapSet.new([:c, :e, :f, :a, :b, :d])
  }

  @unique_length_segment_map %{
    1 => MapSet.new([:c, :f]),
    4 => MapSet.new([:b, :c, :d, :f]),
    7 => MapSet.new([:a, :c, :f]),
    8 => MapSet.new([:a, :b, :c, :d, :e, :f, :g]),
  }

  def part1(filename) do
    filename
    |> File.stream!
    |> Enum.map(&count_known_output(&1))
    #|> List.flatten
    #|> Enum.frequencies
  end

  def part2(filename) do
    filename
    |> File.stream!
    |> Enum.map(&count_all_output(&1))
    #|> List.flatten
    #|> Enum.frequencies
  end

  def count_known_output(line) do
    length_to_num = Map.new(@unique_length_segment_map, fn {key, val} -> {MapSet.size(val), key} end)
    [input | output] =
      line
      |> String.split("|")
      |> Enum.map(&String.trim(&1))

    output
    |> hd
    |> String.split(" ")
    |> Enum.map(&String.graphemes(&1) |> Enum.map(fn(graphmeme) -> String.to_existing_atom(graphmeme) end))
    |> Enum.map(&MapSet.new(&1))
    |> Enum.map(&Map.get(length_to_num, MapSet.size(&1)))
  end

  def count_all_output(line) do
    set_to_num = Map.new(@segment_map, fn {key, val} -> {val, key} end)
    IO.inspect(set_to_num)
    [input | output] =
      line
      |> String.split("|")
      |> Enum.map(&String.trim(&1))

    output
    |> hd
    |> String.split(" ")
    |> Enum.map(&String.graphemes(&1) |> Enum.map(fn(graphmeme) -> String.to_existing_atom(graphmeme) end))
    |> Enum.map(&MapSet.new(&1))
    |> Enum.map(&Map.get(set_to_num, &1))
  end
end
