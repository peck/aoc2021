defmodule Aoc2021.Day9 do

  def part1(filename) do
    grid = load_grid_map(filename)

    low_values = Enum.reduce(grid, [], fn({{x,y}, val}, acc) ->
      neighbors = get_neighbor_values(grid, {x,y})
      #just sort and get hd
      lowest = Enum.map(neighbors, fn(x) -> x > val end) |> Enum.sort |> hd
      if lowest == true, do: [val | acc], else: acc
    end)

    low_values
    |> Enum.map(&Kernel.+(&1, 1))
    |> Enum.sum
  end

  def part2(filename) do
    grid = load_grid_map(filename)

    basins = Enum.reduce(grid, [], fn({{x,y}, val}, acc) ->
      neighbors = get_neighbor_values(grid, {x,y})
      #just sort and get hd
      lowest = Enum.map(neighbors, fn(x) -> x > val end) |> Enum.sort |> hd
      if lowest == true, do: [[ get_basin_neighbors(grid, {x, y}) | [{x,y}]] | acc], else: acc
    end)
    |> Enum.map(&List.flatten(&1) |> Enum.uniq |> Enum.count)
  end

  defp load_grid_map(filename) do
    filename
    |> File.stream!
    |> Enum.map(fn(row) -> String.trim(row) |> String.graphemes() end)
    |> Enum.map(fn(row) -> Enum.with_index(row) end)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({row, rindex}, acc) ->
      Enum.reduce(row, acc, fn({col, cindex}, acc) ->
        Map.put(acc, {rindex, cindex}, String.to_integer(col))
      end)
    end)

  end

  defp get_neighbor_values(grid = %{}, pos = {x, y}) do
    n = Map.get(grid, {x, y-1})
    e = Map.get(grid, {x+1, y})
    s = Map.get(grid, {x, y+1})
    w = Map.get(grid, {x-1, y})
    [n, e, s, w]
  end

  defp get_basin_neighbors(grid = %{}, pos = {x, y}) do
    current_value = Map.get(grid, pos)

    n_val = Map.get(grid, {x, y-1})
    e_val = Map.get(grid, {x+1, y})
    s_val = Map.get(grid, {x, y+1})
    w_val = Map.get(grid, {x-1, y})

    n = if is_nil(n_val) || n_val == 9 || n_val <= current_value, do: nil, else: {x, y-1}
    e = if is_nil(e_val) || e_val == 9 || e_val <= current_value, do: nil, else: {x+1, y}
    s = if is_nil(s_val) || s_val == 9 || s_val <= current_value, do: nil, else: {x, y+1}
    w = if is_nil(w_val) || w_val == 9 || w_val <= current_value, do: nil, else: {x-1, y}

    basin_positions =
    [n, e, s, w]
    |> Enum.reject(&is_nil(&1))
    |> Enum.map(fn(pos) -> [pos] ++ get_basin_neighbors(grid, pos) end)
  end

end
