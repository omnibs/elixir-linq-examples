defmodule ElixirLinqExamples.Generation do
  use ExUnit.Case

  test "linq65: Range" do
    require Integer

    numbers = 100..151
      |> Enum.map(fn x -> %{number: x, odd_even: if(Integer.is_odd(x), do: "odd", else: "even")} end)

    # for n <- numbers, do: IO.puts "The number #{n.number} is #{n.odd_even}"

    assert "even" == hd(numbers).odd_even && "odd" == Enum.at(numbers, 1).odd_even
  end

  test "linq66: Repeat" do
    numbers = List.duplicate(7, 10)

    # for n <- numbers, do: IO.puts n

    assert 10 == length(numbers)
  end
end