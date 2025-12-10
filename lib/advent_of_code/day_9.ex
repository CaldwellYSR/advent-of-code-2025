defmodule AdventOfCode.Day9 do
  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    coords =
      data
      |> String.split("\n", trim: true)
      |> Enum.map(&Vector2.parse/1)

    pairs = for a <- coords, b <- coords, a != b, a < b, do: {a, b}

    Enum.map(pairs, fn {a, b} ->
      Vector2.get_area(a, b)
    end)
    |> Enum.max()
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(_data) do
    -1
  end
end
