defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "part 1 works with sample data" do
    assert Day2.part1("priv/data/day2/sample_data") == 150
  end

  test "part 2 works with sample data" do
    assert Day2.part2("priv/data/day2/sample_data") == 900
  end

end
