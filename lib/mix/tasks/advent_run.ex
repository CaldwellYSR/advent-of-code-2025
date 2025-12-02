defmodule Mix.Tasks.AdventRun do
  @moduledoc """
  # Runs AdventOfCode Puzzles

  ## Examples
  - `mix advent_run` Runs all puzzles
  - `mix advent_run --bench` Runs benchmarks on all puzzles
  - `mix advent_run -b` Runs benchmarks on all puzzles
  - `mix advent_run --day 1` Runs all puzzles on day 1
  - `mix advent_run -d 1` Runs all puzzles on day 1
  - `mix advent_run --day 1 --puzzle_one` Runs puzzle 1 on day 1
  - `mix advent_run -d 1 -p1` Runs puzzle 1 on day 1
  """

  @shortdoc "Runs AdventOfCode Puzzles"

  use Mix.Task

  @days %{
    1 => AdventOfCode.Day1
  }

  @impl Mix.Task
  def run(args) do
    {parsed_args, _, _} =
      OptionParser.parse(args,
        aliases: [b: :bench, d: :day, p1: :puzzle_one, p2: :puzzle_two],
        strict: [bench: :boolean, day: :integer, puzzle_one: :boolean, puzzle_two: :boolean]
      )

    parsed_args
    |> Map.new()
    |> run_puzzles()
  end

  defp run_puzzles(%{day: day} = args) do
    {:ok, day_input_data} =
      :code.priv_dir(:advent_of_code)
      |> Path.join("data/day_#{day}.txt")
      |> File.read()

    Map.fetch(@days, day)
    |> run_day_puzzle(day_input_data, args)
  end

  defp run_puzzles(args) do
    Enum.each(@days, fn {day, day_module} ->
      {:ok, day_input_data} =
        :code.priv_dir(:advent_of_code)
        |> Path.join("data/day_#{day}.txt")
        |> File.read()

      run_day_puzzle({:ok, day_module}, day_input_data, args)
    end)
  end

  defp run_day_puzzle(:error, _day_input_data, _args),
    do: Mix.shell().info("That day doesn't exist")

  defp run_day_puzzle({:ok, day_module}, day_input_data, %{bench: true} = args) do
    run_day_puzzle_with_benchmarks(day_module, day_input_data, args)
  end

  defp run_day_puzzle({:ok, day_module}, day_input_data, %{puzzle_one: true, puzzle_two: true}) do
    IO.puts("===== #{day_module} =========================")
    IO.inspect(apply(day_module, :puzzle_one, [day_input_data]), label: "Puzzle One")
    IO.inspect(apply(day_module, :puzzle_two, [day_input_data]), label: "Puzzle Two")
  end

  defp run_day_puzzle({:ok, day_module}, day_input_data, %{puzzle_one: true}) do
    IO.puts("===== #{day_module} =========================")
    IO.inspect(apply(day_module, :puzzle_one, [day_input_data]), label: "Puzzle One")
  end

  defp run_day_puzzle({:ok, day_module}, day_input_data, %{puzzle_two: true}) do
    IO.puts("===== #{day_module} =========================")
    IO.inspect(apply(day_module, :puzzle_two, [day_input_data]), label: "Puzzle Two")
  end

  defp run_day_puzzle({:ok, day_module}, day_input_data, _args) do
    IO.puts("===== #{day_module} =========================")
    IO.inspect(apply(day_module, :puzzle_one, [day_input_data]), label: "Puzzle One")
    IO.inspect(apply(day_module, :puzzle_two, [day_input_data]), label: "Puzzle Two")
  end

  defp run_day_puzzle_with_benchmarks(day_module, day_input_data, %{
         puzzle_one: true,
         puzzle_two: true
       }) do
    IO.puts("===== #{day_module} =========================")

    Benchee.run(%{
      "Puzzle One" => fn -> apply(day_module, :puzzle_one, [day_input_data]) end,
      "Puzzle Two" => fn -> apply(day_module, :puzzle_two, [day_input_data]) end
    })
  end

  defp run_day_puzzle_with_benchmarks(day_module, day_input_data, %{puzzle_one: true}) do
    IO.puts("===== #{day_module} =========================")

    Benchee.run(%{
      "Puzzle One" => fn -> apply(day_module, :puzzle_one, [day_input_data]) end
    })
  end

  defp run_day_puzzle_with_benchmarks(day_module, day_input_data, %{puzzle_two: true}) do
    IO.puts("===== #{day_module} =========================")

    Benchee.run(%{
      "Puzzle Two" => fn -> apply(day_module, :puzzle_two, [day_input_data]) end
    })
  end

  defp run_day_puzzle_with_benchmarks(day_module, day_input_data, _args) do
    IO.puts("===== #{day_module} =========================")

    Benchee.run(%{
      "Puzzle One" => fn -> apply(day_module, :puzzle_one, [day_input_data]) end,
      "Puzzle Two" => fn -> apply(day_module, :puzzle_two, [day_input_data]) end
    })
  end
end
