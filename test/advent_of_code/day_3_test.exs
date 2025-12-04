defmodule AdventOfCode.Day3Test do
  use ExUnit.Case

  import AdventOfCode.Day3

  setup do
    {:ok, input_data} =
      :code.priv_dir(:advent_of_code)
      |> Path.join("test/day_3.txt")
      |> File.read()

    {:ok, input_data: input_data}
  end

  describe "puzzle_one/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 357
      assert puzzle_one(data) == expected
    end
  end

  describe "puzzle_two/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = -1
      assert puzzle_two(data) == expected
    end
  end
end
