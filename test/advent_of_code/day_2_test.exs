defmodule AdventOfCode.Day2Test do
  use ExUnit.Case

  alias AdventOfCode.Day2

  setup do
    {:ok, input_data} =
      :code.priv_dir(:advent_of_code)
      |> Path.join("test/day_2.txt")
      |> File.read()

    {:ok, input_data: input_data}
  end

  describe "puzzle_one/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 1_227_775_554
      assert Day2.puzzle_one(data) == expected
    end
  end

  describe "puzzle_two/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 4_174_379_265
      assert Day2.puzzle_two(data) == expected
    end
  end
end
