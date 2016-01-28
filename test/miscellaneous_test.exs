defmodule ElixirLinqExamples.Miscellaneous do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq94: Concat - 1" do
    numbers_a = [0, 2, 4, 5, 6, 8, 9]
    numbers_b = [1, 3, 5, 7, 8]

    all_numbers = numbers_a ++ numbers_b

    # IO.puts "All numbers from both arrays:"
    # for n <- all_numbers, do: IO.puts n

    assert 12 == length(all_numbers)
  end

  test "linq95: Concat - 2" do
    customers = get_customer_list()
    products = get_product_list()

    customer_names = customers |> Enum.map(fn x -> x.name end)
    product_names = products |> Enum.map(fn x -> x.product_name end)

    all_names = customer_names ++ product_names

    # IO.puts "Customer and product names:"
    # for n <- all_names, do: IO.puts n

    assert 168 == length(all_names)
  end

  test "linq96: EqualAll - 1" do
    words_a = ["cherry", "apple", "blueberry"]
    words_b = ["cherry", "apple", "blueberry"]

    # IO.puts "The sequences match: #{words_a == words_b}"

    assert words_a == words_b
  end

  test "linq97: EqualAll - 2" do
    words_a = ["cherry", "apple", "blueberry"]
    words_b = ["apple", "blueberry", "cherry"]

    match = words_a == words_b

    # IO.puts "The sequences match: #{match}"

    refute match
  end
end
