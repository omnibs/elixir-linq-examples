defmodule ElixirLinqExamples.Element do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq58: First - Simple" do
    products = get_product_list()

    product12 = products |> Enum.filter(fn x -> x.product_id == 12 end) |> Enum.at(0)

    # IO.inspect product12

    assert "Queso Manchego La Pastora" == product12.product_name
  end

  test "linq59: First - Condition" do
    strings = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    starts_with_o = strings |> Enum.find(fn x -> String.at(x, 0) == "o" end)

    # IO.puts "A string starting with 'o': #{starts_with_o}"

    assert "one" == starts_with_o
  end

  test "linq61: FirstOrDefault - Simple" do
    numbers = []

    first_num_or_default = numbers |> Enum.at(0, 0)

    # IO.puts first_num_or_default

    assert 0 == first_num_or_default
  end

  test "linq62: FirstOrDefault - Condition" do
    products = get_product_list()

    product789 = products |> Enum.find(fn x -> x.product_id == 789 end)

    # IO.puts "Product 789 exists: #{product789 != nil}"

    assert product789 == nil
  end

  test "linq64: ElementAt" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    fourth_low_num = numbers
      |> Enum.filter(fn x -> x > 5 end)
      |> Enum.at(1)

    # IO.puts "Second number > 5: #{fourth_low_num}"

    assert 8 == fourth_low_num
  end
end
