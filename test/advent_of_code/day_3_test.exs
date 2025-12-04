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
      expected = 3_121_910_778_619
      assert puzzle_two(data) == expected
    end

    test "Given 234234234234278 returns 434234234278", %{input_data: data} do
      input = "234234234234278\n"
      expected = 434_234_234_278
      assert puzzle_two(input) == expected
    end

    test "Given first bank of test data, returns something" do
      input =
        "2323233732423333335633333322134234324554233323746324333322454233432477323332532436412434167322334333\n"

      expected = -1
      assert puzzle_two(input) == expected
    end
  end
end
