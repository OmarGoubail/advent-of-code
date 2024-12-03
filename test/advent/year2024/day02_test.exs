defmodule Advent.Year2024.Day02Test do
  use ExUnit.Case

  import Elixir.Advent.Year2024.Day02

  # @tag :skip
  test "part1" do
    input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    result = part1(input)

    assert is_adjacent_difference_safe?(1, 2) == true
    assert is_adjacent_difference_safe?(6, 2) == false
    assert is_adjacent_difference_safe?(4, 4) == false
    assert is_adjacent_difference_safe?(5, 3) == true
    assert is_adjacent_difference_safe?(5, 1) == false
    assert is_adjacent_difference_safe?(5, 5) == false
    assert is_adjacent_difference_safe?(1, 3) == true

    assert is_safe_report?([7, 6, 4, 2, 1]) == true
    assert is_safe_report?([1, 2, 7, 8, 9]) == false
    assert is_safe_report?([8, 6, 4, 4, 1]) == false
    assert is_safe_report?([1, 3, 6, 7, 9]) == true

    assert is_potentially_safe_report?([7, 6, 4, 2, 1]) == true
    assert is_potentially_safe_report?([1, 2, 7, 8, 9]) == false
    assert is_potentially_safe_report?([1, 3, 2, 4, 5]) == true

    assert result == 2
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
