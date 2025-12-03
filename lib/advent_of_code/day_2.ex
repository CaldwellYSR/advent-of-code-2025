defmodule AdventOfCode.Day2 do
  require Integer

  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    data
    |> String.trim()
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.map(fn [left, right] ->
      {
        String.to_integer(left),
        String.to_integer(right)
      }
    end)
    |> Enum.reduce(0, fn {left, right}, acc ->
      count =
        Enum.reduce(left..right, 0, fn x, sum ->
          num = "#{x}"

          check_for_invalid_id(num, String.length(num), x, sum)
        end)

      acc + count
    end)
  end

  defp check_for_invalid_id(num, length, x, sum) when Integer.is_even(length) do
    half_length = Integer.floor_div(length, 2)

    left_side = String.slice(num, 0, half_length)
    right_side = String.slice(num, -half_length, half_length)

    if String.equivalent?(left_side, right_side) do
      sum + x
    else
      sum
    end
  end

  defp check_for_invalid_id(_num, _length, _x, sum), do: sum

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    data
    |> String.trim()
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.map(fn [left, right] ->
      {
        String.to_integer(left),
        String.to_integer(right)
      }
    end)
    |> Enum.reduce(0, fn {left, right}, acc ->
      count =
        Enum.reduce(left..right, 0, fn x, sum ->
          num = "#{x}"

          check_for_puzzle_2_invalid_ids(num, x, sum)
        end)

      acc + count
    end)
  end

  defp check_for_puzzle_2_invalid_ids(num, x, sum) do
    num_length = String.length(num)

    total =
      num_length
      |> get_factors()
      |> Enum.map(fn
        factor when num_length == factor ->
          nil

        factor ->
          unique =
            String.codepoints(num)
            |> Enum.chunk_every(factor)
            |> Enum.map(&Enum.join/1)
            |> Enum.uniq()
            |> Enum.count()

          if unique == 1 do
            x
          else
            nil
          end
      end)
      |> Enum.reject(fn x -> is_nil(x) end)
      |> Enum.uniq()
      |> Enum.sum()

    sum + total
  end

  defp get_factors(x) when x < 1, do: []
  defp get_factors(x), do: do_factors_of(x, 1, [])

  defp do_factors_of(x, divisor, acc) when divisor * divisor > x, do: Enum.reverse(acc)

  defp do_factors_of(x, divisor, acc) do
    if rem(x, divisor) == 0 do
      factor = div(x, divisor)
      new_acc = if divisor == factor, do: [divisor | acc], else: [divisor, factor | acc]
      do_factors_of(x, divisor + 1, new_acc)
    else
      do_factors_of(x, divisor + 1, acc)
    end
  end
end
