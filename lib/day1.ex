defmodule Aoc2021.Day1 do
  @moduledoc """
  Main module for Day1, https://adventofcode.com/2021/day/1
  """

  defp direction_finder([_h | []]) do
    []
  end

  defp direction_finder([h | t] = _values) do
    diff = h - hd(t)
    cond do
      diff < 0 ->
        [:increased] ++ direction_finder(t)
      diff > 0 ->
        [:decreased] ++ direction_finder(t)
      0 ->
        [:stable] ++ direction_finder(t)
    end
  end

  @doc """
  Returns the frequency of increased or decreased samples listed in the passed in file

  Returns `%{increased: <num>, decreased: <num>}`.

  """
  def depth_frequency(file_name) do
    #probably should stream it but we'll be lazy
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> direction_finder()
    |> Enum.frequencies
  end

  @doc """
  Returns the frequency of increased or decreased samples listed in the passed in file using a sliding window

  Returns `%{increased: <num>, decreased: <num>}`.

  """
  def depth_frequency_window(file_name, window_size \\ 3) do
    #probably should stream it but we'll be lazy
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(window_size, 1)
    |> Enum.map(&Enum.sum(&1))
    |> direction_finder()
    |> Enum.frequencies
  end

end
