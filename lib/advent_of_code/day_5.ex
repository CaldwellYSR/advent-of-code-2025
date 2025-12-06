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

    valid_id_map =
      valid_ids
      |> String.split()
      |> Enum.map(fn range ->
        [start, finish] = String.split(range, "-")

        Range.new(String.to_integer(start), String.to_integer(finish))
      end)
      |> Enum.reduce([], fn %Range{first: low, last: high} = range, acc ->
        intersect_low =
          Enum.find(acc, fn %Range{first: first, last: last} ->
            low >= first and low <= last
          end)

        intersect_high =
          Enum.find(acc, fn %Range{first: first, last: last} ->
            high >= first and high <= last
          end)

        this_range_left =
          Enum.filter(acc, fn %Range{last: last} ->
            last < low
          end)

        this_range_right =
          Enum.filter(acc, fn %Range{first: first} ->
            first > high
          end)

        case {intersect_low, intersect_high} do
          {nil, nil} ->
            this_range_left ++ [range] ++ this_range_right

          {%Range{} = x, nil} ->
            this_range_left ++ [x.first..high] ++ this_range_right

          {nil, %Range{} = y} ->
            this_range_left ++ [low..y.last] ++ this_range_right

          {%Range{} = x, %Range{} = y} ->
            this_range_left ++ [x.first..y.last] ++ this_range_right
        end
      end)
      |> Enum.map(&Range.size/1)
      |> Enum.sum()
  end
end
