defmodule Advent.Year2024.Day01 do
  @doc """
  Part 1

  Problem:
  Two groups compile two different lists in an effor to find the Chief Historian.

  The lists aren't very similar, we need to reconcile the differences between them.

  We need to Pair the smallest number in the left list, with the smallest number in the right list, then the second smallest  in the left list with the second smallest in the right list, and so on.

  Within each pair, we need to measure the distance, then add that to the total distance.

  a 3 from the left, and 7 from the right, hava a distance of 4 apart.

  Breakdown:
  Basiaclly, I have two list pairs, that I read into two pairs then I need to sort them, pair them, then measure the distance between them.


  """
  def part1(args) do
    {left, right} = extract_lists(args)

    sorted_left = Enum.sort(left, :asc)

    sorted_right = Enum.sort(right, :asc)

    Enum.zip(sorted_left, sorted_right)
    |> Enum.map(fn {left, right} -> abs(left - right) end)
    |> Enum.sum()
  end

  @doc """
   Part 2

   a lot of loaction Id's appear to be misinterpreted handwriting, now we need to figure how often each number from the left list appears in the right list.
   by adding up each number in the left list after multiplying it by the number of times that number appears in the right list.

   The first number in the left list is 3. It appears in the right list three times, so the similarity score increases by 3 * 3 = 9.


  """
  def part2(args) do
    {left, right} = extract_lists(args)

    Enum.map(
      left,
      fn num ->
        count = Enum.count(right, fn x -> x == num end)
        count * num
      end
    )
    |> Enum.sum()
  end

  defp extract_lists(args) do
    String.split(args, "\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn
      [left, right] -> {String.to_integer(left), String.to_integer(right)}
      _ -> nil
    end)
    |> Enum.unzip()
  end
end
