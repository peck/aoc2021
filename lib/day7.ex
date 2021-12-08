defmodule Aoc2021.Day7 do
  def part1(starting_positions) when is_list(starting_positions) do
    {min, max} =
    starting_positions
    |> Enum.min_max

    Enum.map(min..max, fn(pos) ->
      {pos, Enum.map(starting_positions, fn(x) -> abs(x - pos) end)}
    end)
    |> Enum.map(fn({pos, diffs}) -> {pos, Enum.sum(diffs)} end)
    |> Enum.min_by(fn{pos, sum} -> sum end)
  end

  def part2(starting_positions) when is_list(starting_positions) do
    {min, max} =
    starting_positions
    |> Enum.min_max

    Enum.map(min..max, fn(pos) ->
      {pos, Enum.map(starting_positions, fn(x) -> Enum.sum(0..abs(x - pos)) end)}
    end)
    |> Enum.map(fn({pos, diffs}) -> {pos, Enum.sum(diffs)} end)
    |> Enum.min_by(fn{pos, sum} -> sum end)
  end
end
