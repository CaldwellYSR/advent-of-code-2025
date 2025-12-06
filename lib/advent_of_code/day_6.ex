defmodule AdventOfCode.Day6 do
  alias AdventOfCode.Grid

  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    grid =
      Grid.to_grid!(data, :whitespace)

    {{_x, operator_row}, _} =
      Enum.max_by(grid, fn {{_x, y}, _char} -> y end)

    # acc map
    # %{
    #  0: {"*", [123, 45, 6]
    # }

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
    Grid.to_grid!(data, :whitespace)

    0
  end
end
