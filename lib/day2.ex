defmodule Aoc2021.Day2 do
  @moduledoc """
  Main module for Day2, https://adventofcode.com/2021/day/2
  """

  def part1(course_file) do
    #really shouldn't read all into memory at once
    distance = File.read!(course_file)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn(command_string) -> String.split(command_string, " ") end)
    |> Enum.map(fn([command_string, command_value_string]) -> {command_string, String.to_integer(command_value_string)} end)
    |> Enum.reduce(%{horizontal: 0, depth: 0}, fn({command, value}, acc) ->
      case command do
        "down" ->
          {_prev, acc} = Map.get_and_update!(acc, :depth, fn(curr_val) ->
          {curr_val, curr_val + value}
        end)
          acc

        "up" ->
          {_prev, acc} = Map.get_and_update!(acc, :depth, fn(curr_val) ->
          {curr_val, curr_val - value}
        end)
          acc

        "forward" ->
          {_prev, acc} = Map.get_and_update!(acc, :horizontal, fn(curr_val) ->
          {curr_val, curr_val + value}
        end)
          acc
      end
    end)
    distance.depth*distance.horizontal
  end

  def part2(course_file) do
    #really shouldn't read all into memory at once
    distance = File.read!(course_file)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn(command_string) -> String.split(command_string, " ") end)
    |> Enum.map(fn([command_string, command_value_string]) -> {command_string, String.to_integer(command_value_string)} end)
    |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, fn({command, value}, acc) ->
      case command do
        "down" ->
          {_prev, acc} = Map.get_and_update!(acc, :aim, fn(curr_val) ->
          {curr_val, curr_val + value}
        end)
          acc

        "up" ->
          {_prev, acc} = Map.get_and_update!(acc, :aim, fn(curr_val) ->
          {curr_val, curr_val - value}
        end)
          acc

        "forward" ->
          {_prev, acc} = Map.get_and_update!(acc, :horizontal, fn(curr_val) ->
          {curr_val, curr_val + value}
          end)

          {_prev, acc} = Map.get_and_update!(acc, :depth, fn(curr_val) ->
          {curr_val, curr_val + (acc[:aim]*value)}
          end)

          acc
      end
    end)
    distance.depth*distance.horizontal
  end
end
