defmodule AdventOfCode.Day7 do
  alias AdventOfCode.Grid

  @start_token "S"
  @split_token "^"
  @empty_token "."
  @beam_token "|"

  @spec puzzle_one(String.t()) :: integer()
  def puzzle_one(data) do
    grid = Grid.to_grid!(data)

    {{start_x, _}, _} =
      Enum.find(grid, fn {_coord, char} -> char == @start_token end)

    {_width, height} = Grid.get_size(grid)

    {_xcoords, split_count, _grid} =
      Enum.reduce(1..height, {[start_x], 0, grid}, fn y, {xcoords, split_count, current_grid} ->
        {new_xcoords, new_count, new_grid} =
          Enum.reduce(xcoords, {[], split_count, current_grid}, fn x,
                                                                   {current_coords, current_count,
                                                                    current_grid} = acc ->
            case Grid.fetch!(current_grid, {x, y}) do
              @empty_token ->
                new_grid = Grid.update_cell(current_grid, {x, y}, @beam_token)
                {current_coords ++ [x], current_count, new_grid}

              @split_token ->
                new_grid = Grid.update_cell(current_grid, {x - 1, y}, @beam_token)
                new_grid = Grid.update_cell(new_grid, {x + 1, y}, @beam_token)
                {current_coords ++ [x - 1, x + 1], current_count + 1, new_grid}

              _ ->
                acc
            end
          end)

        {Enum.dedup(new_xcoords), new_count, new_grid}
      end)

    split_count
  end

  @spec puzzle_two(String.t()) :: integer()
  def puzzle_two(data) do
    grid = Grid.to_grid!(data)

    {{start_x, _}, _} =
      Enum.find(grid, fn {_coord, char} -> char == @start_token end)

    {_width, height} = Grid.get_size(grid)

    {_xcoords, split_count, _grid} =
      Enum.reduce(1..height, {[start_x], 0, grid}, fn y, {xcoords, split_count, current_grid} ->
        {new_xcoords, new_count, new_grid} =
          Enum.reduce(xcoords, {[], split_count, current_grid}, fn x,
                                                                   {current_coords, current_count,
                                                                    current_grid} = acc ->
            case Grid.fetch!(current_grid, {x, y}) do
              @empty_token ->
                new_grid = Grid.update_cell(current_grid, {x, y}, @beam_token)
                {current_coords ++ [x], current_count, new_grid}

              @split_token ->
                new_grid = Grid.update_cell(current_grid, {x - 1, y}, @beam_token)
                new_grid = Grid.update_cell(new_grid, {x + 1, y}, @beam_token)
                {current_coords ++ [x - 1, x + 1], current_count + 1, new_grid}

              _ ->
                acc
            end
          end)

        {Enum.dedup(new_xcoords), new_count, new_grid}
      end)

    split_count
  end
end
