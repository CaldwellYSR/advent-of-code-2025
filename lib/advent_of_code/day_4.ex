defmodule AdventOfCode.Day4 do
  alias AdventOfCode.Grid

  @paper "@"
  @empty "."
  @marked_for_deletion "x"

  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    grid = Grid.to_grid!(data)

    {_grid, count} =
      Enum.reduce(grid, {grid, 0}, fn {coord, char}, acc ->
        check_coord(acc, coord, char)
      end)

    count
  end

  defp check_coord(acc, _coord, @empty), do: acc

  defp check_coord({grid, count} = acc, coord, @paper) do
    {grid, paper_count} =
      grid
      |> Grid.get_neighbors(coord)
      |> Enum.reduce({grid, 0}, fn neighbor_coord, {grid, paper_count} ->
        case Grid.fetch(grid, neighbor_coord) do
          {:ok, @paper} ->
            {grid, paper_count + 1}

          _ ->
            {grid, paper_count}
        end
      end)

    if paper_count < 4 do
      {grid, count + 1}
    else
      acc
    end
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    grid = Grid.to_grid!(data)

    count =
      Stream.iterate(0, &(&1 + 1))
      |> Enum.reduce_while({grid, 0}, fn _iteration, {current_grid, current_count} ->
        {iteration_grid, iteration_count} =
          Enum.reduce(current_grid, {current_grid, 0}, fn {coord, char}, grid_instance_acc ->
            check_coord_with_replacement(grid_instance_acc, coord, char)
          end)

        case iteration_count do
          0 ->
            {:halt, current_count + iteration_count}

          count ->
            grid =
              Enum.reduce(iteration_grid, iteration_grid, fn
                {coord, @marked_for_deletion}, grid ->
                  {_, grid} = Map.get_and_update(grid, coord, fn c -> {c, @empty} end)
                  grid

                _, grid ->
                  grid
              end)

            {:cont, {grid, current_count + count}}
        end
      end)

    count
  end

  defp check_coord_with_replacement(acc, _coord, @empty), do: acc

  defp check_coord_with_replacement({grid, count} = acc, coord, _char) do
    {grid, paper_count} =
      grid
      |> Grid.get_neighbors(coord)
      |> Enum.reduce({grid, 0}, fn neighbor_coord, {grid, paper_count} ->
        case Grid.fetch(grid, neighbor_coord) do
          {:ok, @paper} ->
            {grid, paper_count + 1}

          {:ok, @marked_for_deletion} ->
            {grid, paper_count + 1}

          _ ->
            {grid, paper_count}
        end
      end)

    if paper_count < 4 do
      {_, grid} = Map.get_and_update(grid, coord, fn c -> {c, @marked_for_deletion} end)
      {grid, count + 1}
    else
      acc
    end
  end
end
