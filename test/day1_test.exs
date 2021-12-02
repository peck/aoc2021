defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "depth_frequency works with sample input" do
    assert Day1.depth_frequency("priv/data/day1/sample_data") == %{decreased: 2, increased: 7}
  end

  test "depth_frequency_window works with sample input" do
    assert Day1.depth_frequency_window("priv/data/day1/sample_data") == %{decreased: 2, increased: 5, stable: 1}
  end
end
