defmodule AdventOfCode.Day4 do
  alias AdventOfCode.Grid

  @paper "@"
  @empty "."

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
    Grid.to_grid!(data)

    0
  end
end
