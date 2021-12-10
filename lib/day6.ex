defmodule Day6 do
  @starter %{
      0 => 0,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0,
      8 => 0,
    }

  def part1(starting_pop, iterations) do
    pop_map =
    starting_pop
    |> Enum.frequencies()
    |> Map.merge(@starter, fn _k, v1, v2 -> v1 end)

    Enum.reduce(0..iterations, pop_map, fn(_x, acc) -> tick(acc) end)
    |> Map.values
    |> Enum.sum
  end

  def tick(population = %{}) do
    population
    |> Enum.reduce(@starter, fn({k,v}, acc) ->
      case k do
        0 ->
          {_, ret} =
            acc
          |> Map.put(8, v)
            |> Map.get_and_update(6, fn(current_value) -> {current_value, current_value + v} end)
          ret

        7 ->
          {_, ret} =
            acc
            |> Map.get_and_update(6, fn(current_value) -> {current_value, current_value + v} end)
          ret

        num ->
          Map.put(acc, num - 1, v)
      end
    end)
  end
end
