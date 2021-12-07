defmodule Day5.Board do
  defstruct [:grid, :height, :width]
  @default_random false

  require Logger
  require IEx

  alias __MODULE__
  alias Day5.Tile

  @type opts :: {:random, boolean()}
  def new(height, width, opts \\ []) do
    board = %{}
    pairs = for x <- 0..(height+1), y <- 0..(width+1), do: {x, y}

    grid =
      Enum.reduce(pairs, board, fn position = {x, y}, board ->
            Map.put(board, position, %Tile{})
      end)

    %Board{grid: grid, height: height, width: width}
  end

  def increment(board = %Board{grid: grid}, {x_pos, y_pos} = pos) do
    t = Map.get(grid, {x_pos, y_pos})
    new_t = %{t | count: t.count + 1}
    update_tile(board, pos, new_t)
  end

  def get_tile(board = %Board{grid: grid}, {x_pos, y_pos}) do
    Map.get(grid, {x_pos, y_pos})
  end

  def update_tile(board = %Board{grid: grid}, pos = {x_pos, y_pos}, new_tile = %Tile{}) do
    grid = Map.put(grid, {x_pos, y_pos}, new_tile)
    %{board | grid: grid}
  end
end

defimpl String.Chars, for: Day5.Board do
  alias Day5.Board

  def to_string(board = %Board{height: height, width: width, grid: grid}) do
    for y <- 0..(width - 1), x <- 0..(height - 1) do
      # Get the string representation of the time
      Kernel.to_string(Board.get_tile(board, {x, y}))
    end
    # add a newline every width
    |> Enum.chunk_every(width)
    |> Enum.reduce("", fn reps, acc ->
      acc <> Kernel.to_string(reps ++ ["\n"])
    end)
  end
end
