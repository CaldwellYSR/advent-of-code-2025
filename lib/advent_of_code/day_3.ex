defmodule AdventOfCode.Day3 do
  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&find_max_joltage_with_length(&1))
    |> Enum.sum()
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&find_max_joltage_with_length(&1, 12))
    |> Enum.sum()
  end

  defp find_max_joltage_with_length(num_str, output_length \\ 2) do
    digits =
      num_str
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    digits_length = length(digits)

    {result, _} =
      Enum.reduce(0..(output_length - 1), {[], 0}, fn i, {acc, start_index} ->
        max_search_index = digits_length - output_length + i

        {best_digit, best_index} =
          start_index..max_search_index
          |> Enum.map(fn index -> {Enum.at(digits, index), index} end)
          |> Enum.max_by(fn {digit, _index} -> digit end)

        {acc ++ [best_digit], best_index + 1}
      end)

    result
    |> Enum.join()
    |> String.to_integer()
  end
end
