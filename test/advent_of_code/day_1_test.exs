defmodule AdventOfCode.Day1Test do
  use ExUnit.Case

  alias AdventOfCode.Day1

  setup do
    {:ok, input_data} =
      :code.priv_dir(:advent_of_code)
      |> Path.join("test/day_1.txt")
      |> File.read()

    {:ok, input_data: input_data}
  end

  describe "part_one/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 3
      assert Day1.part_one(data) == expected
    end
  end

  describe "part_two/1" do
    test "Given test input, returns expected answer", %{input_data: data} do
      expected = 6
      assert Day1.part_two(data) == expected
    end
  end
end
