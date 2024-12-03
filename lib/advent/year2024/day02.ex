defmodule Advent.Year2024.Day02 do
  @doc """
  Part 1

  Problem:
  The historians went crazy again, this time they've divided into multiple groups, and generated many reports from The Red Nosed Reactor, The data consists of many reports per line. Each report is a list of numbers called levels, that are seperated by spaces.

  for example:
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9

  This example data contains six reports each containing five levels.

  To figure out which reports are safe, the following must be true:
  - The levels are either all increasing or all decreasing.
  - Any two adjacent levels differ by at least one and at most three.

  7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
  1 2 7 8 9: Unsafe because 2 7 is an increase of 5.

  we need to parse the strings to arrays first
  """
  def part1(args) do
    extract_reports(args)
  end

  @doc """
  Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

  More of the above example's reports are now safe:

      7 6 4 2 1: Safe without removing any level.
      1 2 7 8 9: Unsafe regardless of which level is removed.
      9 7 6 2 1: Unsafe regardless of which level is removed.
      1 3 2 4 5: Safe by removing the second level, 3.
      8 6 4 4 1: Safe by removing the third level, 4.
      1 3 6 7 9: Safe without removing any level.

      need to tolerate one unsafe level

  """
  def part2(args) do
    extract_reports_part2(args)
  end

  def is_potentially_safe_report?(arr) do
    # First check if it's already safe
    if is_safe_report?(arr) do
      true
    else
      # Try removing one number at a time and check if any resulting sequence is safe
      generate_subsequences(arr)
      |> Enum.any?(&is_safe_report?/1)
    end
  end

  def generate_subsequences(list) do
    0..(length(list) - 1)
    |> Enum.map(fn index ->
      List.delete_at(list, index)
    end)
  end

  @doc """
    ## Solution outline
    We can check the array for all conditions together, we take the first element and check if it is decreasing or increasing, then we check the rest of the array and if the difference between the adjacent elements is within the range of 1-3, then we return true, otherwise we return false

  """
  def is_safe_report?(arr) do
    chunks = Enum.chunk_every(arr, 2, 1, :discard)
    safe_differenes = chunks |> Enum.all?(fn [x, y] -> is_adjacent_difference_safe?(x, y) end)

    [first, second | _] = arr
    initial_direction = if second > first, do: :increasing, else: :decreasing

    consistend_directions =
      chunks
      |> Enum.all?(fn [x, y] ->
        case initial_direction do
          :increasing -> y > x
          :decreasing -> y < x
        end
      end)

    safe_differenes && consistend_directions
  end

  @doc """
  To figure out which reports are safe, the following must be true:
  - The levels are either all increasing or all decreasing.
  - Any two adjacent levels differ by at least one and at most three.
  """
  def is_adjacent_difference_safe?(x, y) when abs(x - y) >= 1 and abs(x - y) <= 3, do: true
  def is_adjacent_difference_safe?(_, _), do: false

  def extract_reports(args) do
    String.split(args, "\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn list ->
      Enum.map(list, &String.to_integer/1)
    end)
    |> Enum.map(&is_safe_report?/1)
    |> Enum.count(&(&1 == true))
  end

  def extract_reports_part2(args) do
    String.split(args, "\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn list ->
      Enum.map(list, &String.to_integer/1)
    end)
    |> Enum.map(&is_potentially_safe_report?/1)
    |> Enum.count(&(&1 == true))
  end
end
