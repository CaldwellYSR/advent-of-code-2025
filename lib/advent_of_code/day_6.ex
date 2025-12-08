defmodule AdventOfCode.Day6 do
  alias AdventOfCode.Grid

  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    grid =
      Grid.to_grid!(data, :whitespace)

    {{_x, operator_row}, _} =
      Enum.max_by(grid, fn {{_x, y}, _char} -> y end)

    problems =
      Enum.reduce(grid, %{}, fn
        {{x, ^operator_row}, operator}, acc ->
          {_, acc} =
            Map.get_and_update(acc, x, fn
              {_, digits} = current ->
                {current, {operator, digits || []}}

              nil ->
                {nil, {operator, []}}
            end)

          acc

        {{x, _y}, digit}, acc ->
          {_, acc} =
            Map.get_and_update(acc, x, fn
              {operator, digits} = current ->
                {current, {operator, digits ++ [String.to_integer(digit)]}}

              nil ->
                {nil, {nil, [String.to_integer(digit)]}}
            end)

          acc
      end)

    problems
    |> Map.values()
    |> Enum.reduce(0, &solve_problems/2)
  end

  defp solve_problems({"+", digits}, acc), do: acc + Enum.sum(digits)

  defp solve_problems({"*", digits}, acc), do: acc + Enum.product(digits)

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    grid = Grid.to_grid!(data, :whitespace)

    {{_x, operator_row}, _} =
      Enum.max_by(grid, fn {{_x, y}, _char} -> y end)

    {{x_length, _y}, _} =
      Enum.max_by(grid, fn {{x, _y}, _char} -> x end)

    transposed_digits =
      for x <- 0..x_length do
        for y <- 0..(operator_row - 1) do
          Map.fetch!(grid, {x, y})
        end
      end
      |> Enum.map(fn row ->
        case Enum.reject(row, fn x -> x == " " end)
             |> Enum.join()
             |> Integer.parse() do
          {x, _} -> x
          :error -> :split
        end
      end)

    operators =
      for x <- 0..x_length do
        Map.fetch!(grid, {x, operator_row})
      end
      |> Enum.reject(fn x -> x == " " end)

    transposed_digits
    |> Enum.reduce([[]], fn
      :split, acc -> [[] | acc]
      item, [current | rest] -> [[item | current] | rest]
    end)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse()
    |> Enum.reject(&(&1 == []))
    |> Enum.with_index()
    |> Enum.map(fn {digits, i} ->
      {Enum.at(operators, i), digits}
    end)
    |> Enum.reduce(0, &solve_problems/2)
  end
end
