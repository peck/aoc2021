defmodule Aoc2021.Day5 do
  alias Day5.Board
  alias Day5.Line

  require Logger

  def part1(file) do
    lines =
    file
    |> File.stream!()
    |> Enum.to_list
    |> Enum.map(fn(line) -> parse_line(line) end)
    |> Enum.filter(fn(line) -> line.x1 == line.x2 || line.y1 == line.y2 end)

    max_x =
      lines
    |> Enum.max_by(&Map.fetch!(&1,:x2))
    |> Map.get(:x2)

    max_y =
      lines
    |> Enum.max_by(&Map.fetch!(&1,:y2))
    |> Map.get(:y2)

    board = Board.new(1000, 1000)

    points =
      lines
    |> Enum.map(&Line.all_points(&1))
    |> List.flatten

    Enum.reduce(points, board, fn(point, board) ->
      Board.increment(board, point)
    end)
    |> Map.fetch!(:grid)
    |> Map.values
    |> Enum.filter(fn(tile) ->
      tile.count >= 2
    end)
    |> Enum.count

  end

  def part2(file) do
    lines =
    file
    |> File.stream!()
    |> Enum.to_list
    |> Enum.map(fn(line) -> parse_line(line) end)


    max_x =
      lines
    |> Enum.max_by(&Map.fetch!(&1,:x2))
    |> Map.get(:x2)
    |> Kernel.+ 1

    max_y =
      lines
    |> Enum.max_by(&Map.fetch!(&1,:y2))
    |> Map.get(:y2)
    |> Kernel.+ 1

    board = Board.new(max_y, max_x)

    points =
      lines
    |> Enum.map(&Line.all_points(&1))
    |> List.flatten

    Enum.reduce(points, board, fn(point, board) ->
      Board.increment(board, point)
    end)
    |> Map.fetch!(:grid)
    |> Map.values
    |> Enum.filter(fn(tile) ->
      tile.count >= 2
    end)
    |> Enum.count

  end

  defp parse_line(line) do
    captures = Regex.named_captures(~r/(?<x1>\d+)\,(?<y1>\d+)\s\-\>\s(?<x2>\d+)\,(?<y2>\d+)$/, line)
    captures_with_atom_keys = for {key, val} <- captures, into: %{} do
  {String.to_existing_atom(key), String.to_integer(val)}
end
    struct(Line, captures_with_atom_keys)
  end

end

defmodule Day5.Line do
  defstruct [:x1, :y1, :x2, :y2]

  def all_points(line = %__MODULE__{x1: x1, x2: x2, y1: y1, y2: y2}) when x1 == x2 or y1 == y2 do
    for x <- line.x1..line.x2, y <- line.y1..line.y2, do: {x, y}
  end

  def all_points(line = %__MODULE__{}) do
    Enum.zip(line.x1..line.x2, line.y1..line.y2)
  end
end
