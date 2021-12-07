defmodule Day5.Tile do
  defstruct [count: 0]
end

defimpl String.Chars, for: Day5.Tile do
  alias Day5.Tile

  def to_string(tile = %Tile{count: 0}) do
    "."
  end

  def to_string(tile = %Tile{count: count}) do
    Kernel.to_string(count)
  end
end
