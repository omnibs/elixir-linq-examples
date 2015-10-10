defmodule ElixirLinqExamples.Quantifiers do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq67: Any - Simple" do
    words = ["believe", "relief", "receipt", "field"]

    i_after_e = words |> Enum.any? fn x -> String.contains?(x, "ei") end

    # IO.puts "There is a word that contains in the list that contains 'ei': #{i_after_e != nil}"

    assert nil != i_after_e
  end

  test "linq69: Any - Grouped" do
    products = get_product_list()

    product_groups = products
      |> Enum.group_by(fn x -> x.category end)
      |> Enum.filter(fn x -> elem(x, 1) |> Enum.any?(fn p -> p.units_in_stock == 0 end) end)
      |> Enum.map fn x -> %{category: elem(x, 0), products: elem(x, 1)} end

    # IO.inspect product_groups
  end

  test "linq70: All - Simple" do
    require Integer

    numbers = [1, 11, 3, 19, 41, 65, 19]

    only_odd = numbers |> Enum.all?(fn x -> Integer.is_odd(x) end)

    # IO.puts "The list contains only odd numbers: #{only_odd}"

    assert only_odd
  end

  test "linq72: All - Grouped" do
    products = get_product_list()

    product_groups = products
      |> Enum.group_by(fn x -> x.category end)
      |> Enum.filter(fn x -> elem(x, 1) |> Enum.all?(fn p -> p.units_in_stock > 0 end) end)
      |> Enum.map fn x -> %{category: elem(x, 0), products: elem(x, 1)} end

    # IO.inspect product_groups
  end
end