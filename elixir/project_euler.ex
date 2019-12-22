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
end
