defmodule AdventOfCode.Day5 do
  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    [valid_ids, tests] = String.split(data, "\n\n")

    valid_id_map =
      valid_ids
      |> String.split()
      |> Enum.map(fn range ->
        [start, finish] = String.split(range, "-")
        Range.new(String.to_integer(start), String.to_integer(finish))
      end)
      |> Enum.sort()

    tests
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reject(fn x ->
      not Enum.any?(valid_id_map, fn range ->
        x in range
      end)
    end)
    |> Enum.count()
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    [valid_ids | _tests] = String.split(data, "\n\n")

    valid_ids
    |> String.split()
    |> Enum.map(fn range ->
      [start, finish] = String.split(range, "-")
      {String.to_integer(start), String.to_integer(finish)}
    end)
    |> Enum.sort()
    |> Enum.reduce([], fn {low, high}, acc ->
      case acc do
        [] ->
          [{low, high}]

        [{prev_low, prev_high} | rest] when low <= prev_high + 1 ->
          [{prev_low, max(prev_high, high)} | rest]

        _ ->
          [{low, high} | acc]
      end
    end)
    |> Enum.map(fn {low, high} -> high - low + 1 end)
    |> Enum.sum()
  end
end
