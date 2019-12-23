defmodule ProjectEuler do
  def p1 do
    1..999
    |> Stream.filter(&(rem(&1, 3) == 0 or rem(&1, 5) == 0))
    |> Enum.sum()
  end

  def p2 do
    {0, 1}
    # Start by writing the stream generates the Fibonacci sequence
    |> Stream.unfold(fn {a, b} -> {b, {b, a + b}} end)
    # Pipe that sequence into a filter that checks for evenness
    |> Stream.filter(fn x -> rem(x, 2) == 0 end)
    # Now, take the values that do not exceed 4e6
    |> Stream.take_while(fn x -> x <= 4_000_000 end)
    # Calculate the sum
    |> Enum.sum()
  end

  def p3 do
    # TODO
  end

  def p4 do
    # Let's start by writing a stream that produces all 899 (999 - 100)
    # palindromes.

    # The product of two 3-digit numbers can never be more than 999_999.
    # It can never be less than 10_000. Since we're working with palindromes,
    # it can never be less than 10_001.

    # I need something like this:
    # 999_999, 998_899, 997_799, ..., 899_998, 898_898, 897_798, ..., 100_001,
    # 99_999, 99899, 99799, 99699, ..., 98989, 98889, 98789, 98689, ...
    # palindromes = Stream.iterate(999_999, fn x -> x - 1_100 end)
    palindromes_six_digits =
      for i <- 0..8, j <- 0..9, k <- 0..9 do
        999_999 - 100_001 * i - 10_010 * j - 1_100 * k
      end

    palindromes_five_digits =
      for i <- 0..8, j <- 0..9, k <- 0..9 do
        99_999 - 10_001 * i - 1_010 * j - 100 * k
      end

    palindromes_six_digits
    |> Stream.concat(palindromes_five_digits)
    |> Enum.find(fn x ->
      Enum.any?(999..100, fn y -> rem(x, y) == 0 and x / y < 1000 end)
    end)
  end

  def benchmark(f) do
    f
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
