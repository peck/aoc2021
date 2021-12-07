defmodule Aoc2021.Day4 do
  require Logger

    def after_func(chunk) do
    {:cont, Enum.reverse(chunk), []}
  end

  #starter function
  def chunker(element, []) do
    {:cont, [element]}
  end

  def chunker(element, [h|t]=acc) do
    cond do
      element == "\n" && h == "\n" ->
        {:cont, Enum.reverse(t), [element] }

      h == "\n" ->
        {:cont, [element | [" " | t] ]}

      true ->
        {:cont, [element | acc] }

    end
  end

  def part1(file) do

    [values | boards] =
      file
    |> File.read!()
    |> String.split("\n\n")

      values =
        values
        |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

      boards =
        boards
        |> Enum.map(fn(board_string) ->
        board_string_rows =
          board_string
        |> String.trim()
        |> String.split("\n")
        |> Enum.map(fn(row) -> String.split(row) |> Enum.map(&String.to_integer(&1)) end)
      end)
        |> Enum.map(fn(x) ->
        board_lists_to_sets(x)
        end)

        Enum.reduce_while(values, [], fn(new_value, called_values) ->
          ret = Enum.map(boards, fn(board) -> {check_board(called_values ++ [new_value], board), board} end)
          if Keyword.has_key?(ret, :true) do
            IO.inspect(called_values ++ [new_value], label: "CALLED NUMBERS")
          remaining_vals =
          ret
        |> Keyword.fetch!(:true)
        |> Enum.map(fn(set) -> MapSet.to_list(set) end)
        |> List.flatten
        |> Enum.reject(fn(x) -> Enum.member?(called_values ++ [new_value], x) end)
        |> Enum.uniq()
        |> IO.inspect(label: "FINAL NUMS")
        |> Enum.sum
        |> IO.inspect(label: "FINAL SUM")
          |> Kernel.* new_value

          {:halt, remaining_vals}
          else
            {:cont, called_values ++ [new_value]}
            end
        end)

  end

  #This gets the solution, but its ugly and requires looking at inspect output.
  def part2(file) do

    [values | boards] =
      file
    |> File.read!()
    |> String.split("\n\n")

      values =
        values
        |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

      boards =
        boards
        |> Enum.map(fn(board_string) ->
        board_string_rows =
          board_string
        |> String.trim()
        |> String.split("\n")
        |> Enum.map(fn(row) -> String.split(row) |> Enum.map(&String.to_integer(&1)) end)
      end)
        |> Enum.map(fn(x) ->
        board_lists_to_sets(x)
        end)

        Enum.reduce_while(values, values, fn(_new_value, called_values) ->
          ret = Enum.map(boards, fn(board) -> {check_board(called_values, board), board} end)
          if Keyword.has_key?(ret, :false) do
            IO.inspect(called_values, label: "CALLED NUMBERS", limit: :infinity)
          remaining_vals =
          ret
        |> Keyword.fetch!(:false)
        |> Enum.map(fn(set) -> MapSet.to_list(set) end)
        |> List.flatten
        |> Enum.reject(fn(x) -> Enum.member?(called_values, x) end)
        |> Enum.uniq()
        |> IO.inspect(label: "FINAL NUMS", limit: :infinity)
        |> Enum.sum
        |> IO.inspect(label: "FINAL SUM")
          |> Kernel.* (Enum.reverse(called_values) |> hd)

          {:halt, remaining_vals}
          else
            {:cont, Enum.drop(called_values, -1)}

            end
        end)

  end

  #This is dumb, don't do this
  def board_lists_to_sets(board) do
    len = length(Enum.at(board, 0))
    rows =
      board
    |> Enum.map(&MapSet.new(&1))
    cols =
      Enum.map(0..len-1, fn(x) ->
        board
        |> Enum.map(fn(row) ->
          Enum.at(row, x)
        end)
        |> MapSet.new
      end)

    rows ++ cols
  end

  def check_board(values, board) do
    valueset = MapSet.new(values)
    Enum.map(board, fn(set) ->
      #Logger.debug("checkng if #{inspect(set)} is a subset of #{inspect(valueset)}")
      MapSet.subset?(set, valueset)
    end)
    |> Enum.member?(true)
  end

end
