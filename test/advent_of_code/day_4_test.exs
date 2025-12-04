defmodule AdventOfCode.Day4Test do
  use ExUnit.Case

  import AdventOfCode.Day4

  setup do
    {:ok, input_data} =
      :code.priv_dir(:advent_of_code)
      |> Path.join("test/day_4.txt")
      |> File.read()

    {:ok, input_data: input_data}
  end

  describe "puzzle_one/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 13
      assert puzzle_one(data) == expected
    end
  end

  describe "puzzle_two/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 3_121_910_778_619
      assert puzzle_two(data) == expected
    end
  end
end
