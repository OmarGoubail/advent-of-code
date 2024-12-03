defmodule Advent.Year2024.Day03 do
  def part1(args) do
    args |> parse_mul() |> sum_multiplications()
  end

  def parse_mul(string) do
    find_muls(string, [])
  end

  def find_muls(<<"mul(", rest::binary>>, acc) do
    case parse_numbers(rest) do
      {:ok, num1, num2, remaining} ->
        find_muls(remaining, [{num1, num2} | acc])

      :error ->
        find_muls(rest, acc)
    end
  end

  def find_muls(<<_::binary-size(1), rest::binary>>, acc) do
    find_muls(rest, acc)
  end

  def find_muls("", acc), do: Enum.reverse(acc)

  def sum_multiplications(mul_list) do
    Enum.reduce(mul_list, 0, fn {n1, n2}, acc -> acc + n1 * n2 end)
  end

  def parse_numbers(string) do
    case String.split(string, ")", parts: 2) do
      [numbers, remaining] ->
        case String.split(numbers, ",") do
          [first_num, second_num] ->
            case {Integer.parse(first_num), Integer.parse(second_num)} do
              {{num1, ""}, {num2, ""}} ->
                {:ok, num1, num2, remaining}

              _ ->
                :error
            end

          _ ->
            :error
        end

      _ ->
        :error
    end
  end

  def part2(args) do
    args
    |> find_muls_with_state([], true)
    |> sum_multiplications()
  end

  # Handle don't() instruction - note the spelling and pattern
  def find_muls_with_state(<<"don't()", rest::binary>>, acc, _state) do
    find_muls_with_state(rest, acc, false)
  end

  # Handle do() instruction - note it might be "undo()"
  def find_muls_with_state(<<"do()", rest::binary>>, acc, _state) do
    find_muls_with_state(rest, acc, true)
  end

  def find_muls_with_state(<<"undo()", rest::binary>>, acc, _state) do
    find_muls_with_state(rest, acc, true)
  end

  # Handle mul when enabled
  def find_muls_with_state(<<"mul(", rest::binary>>, acc, true = state) do
    case parse_numbers(rest) do
      {:ok, num1, num2, remaining} ->
        find_muls_with_state(remaining, [{num1, num2} | acc], state)

      :error ->
        find_muls_with_state(rest, acc, state)
    end
  end

  # Handle mul when disabled
  def find_muls_with_state(<<"mul(", rest::binary>>, acc, false = state) do
    case parse_numbers(rest) do
      {:ok, _num1, _num2, remaining} ->
        find_muls_with_state(remaining, acc, state)

      :error ->
        find_muls_with_state(rest, acc, state)
    end
  end

  # Skip character and maintain state
  def find_muls_with_state(<<char::binary-size(1), rest::binary>>, acc, state) do
    find_muls_with_state(rest, acc, state)
  end

  # Base case
  def find_muls_with_state("", acc, _state), do: Enum.reverse(acc)
end
