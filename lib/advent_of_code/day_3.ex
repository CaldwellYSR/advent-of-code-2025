defmodule AdventOfCode.Day3 do
  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&find_max_joltage/1)
    |> Enum.sum()
  end

  defp find_max_joltage(num_str) do
    digits =
      num_str
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(digits, {0, nil}, fn digit, {max_concat, best_first} ->
      new_max = if best_first, do: max(max_concat, best_first * 10 + digit), else: 0
      new_best = if best_first, do: max(best_first, digit), else: digit
      {new_max, new_best}
    end)
    |> elem(0)
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    0
  end
end
