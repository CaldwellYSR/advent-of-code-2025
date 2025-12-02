defmodule AdventOfCode.Day1 do
  @start 50

  @spec part_one(String.t()) :: integer()
  def part_one(data) when is_binary(data) do
    {sum, _final_position} =
      data
      |> String.trim()
      |> String.split("\n")
      |> Enum.reduce({0, @start}, fn
        "L" <> num, {sum, position} ->
          move_dial(String.to_integer(num), sum, position, &Kernel.-/2)

        "R" <> num, {sum, position} ->
          move_dial(String.to_integer(num), sum, position, &Kernel.+/2)
      end)

    sum
  end

  def part_two(data) do
    {sum, _final_position} =
      data
      |> String.trim()
      |> String.split("\n")
      |> Enum.reduce({0, @start}, fn
        "L" <> num, {sum, position} ->
          move_dial(String.to_integer(num), sum, position, &Kernel.-/2, :passes_zero)

        "R" <> num, {sum, position} ->
          move_dial(String.to_integer(num), sum, position, &Kernel.+/2, :passes_zero)
      end)

    sum
  end

  defp move_dial(clicks, sum, position, operator, count_method \\ :stops_at_zero) do
    new_position =
      operator.(position, clicks)

    actual_position =
      Integer.mod(new_position, 100)

    new_sum = get_new_sum(position, new_position, actual_position, sum, count_method)

    {new_sum, actual_position}
  end

  defp get_new_sum(_old_position, _new_position, 0, sum, :stops_at_zero), do: sum + 1
  defp get_new_sum(_old_position, _new_position, _actual_position, sum, :stops_at_zero), do: sum

  defp get_new_sum(_old_position, new_position, _actual_position, sum, :passes_zero)
       when new_position >= 100 do
    new_position
    |> Integer.floor_div(100)
    |> Kernel.+(sum)
  end

  defp get_new_sum(0, new_position, _actual_position, sum, :passes_zero)
       when new_position <= 0 do
    new_position
    |> abs()
    |> Integer.floor_div(100)
    |> Kernel.+(sum)
  end

  defp get_new_sum(_old_position, new_position, _actual_position, sum, :passes_zero)
       when new_position <= 0 do
    new_position
    |> abs()
    |> Kernel.+(100)
    |> Integer.floor_div(100)
    |> Kernel.+(sum)
  end

  defp get_new_sum(_old_position, _new_position, _actual_position, sum, :passes_zero), do: sum
end
