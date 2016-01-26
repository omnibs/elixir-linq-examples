defmodule ElixirLinqExamples.Quantifiers do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq67: Any - Simple" do
    words = ["believe", "relief", "receipt", "field"]

    i_after_e = words |> Enum.any?(fn x -> String.contains?(x, "ei") end)

    # IO.puts "There is a word that contains in the list that contains 'ei': #{i_after_e != nil}"

    assert nil != i_after_e
  end

  test "linq69: Any - Grouped" do
    products = get_product_list()

    product_groups = products
      |> Enum.group_by(fn x -> x.category end)
      |> Enum.filter(fn {_,prods} -> prods |> Enum.any?(fn p -> p.units_in_stock == 0 end) end)
      |> Enum.map(fn {cat, prods} -> %{category: cat, products: prods} end)

    assert 3 == length(product_groups)
    first_group = product_groups|> Enum.at(0)
    assert first_group.category == "Condiments"
    assert first_group.products |> Enum.count == 12
  end

  test "linq70: All - Simple" do
    require Integer
    numbers = [1, 11, 3, 19, 41, 65, 19]
    only_odd = numbers |> Enum.all?(fn x -> Integer.is_odd(x) end)

    assert only_odd == true
  end

  test "linq72: All - Grouped" do
    products = get_product_list()

    product_groups = products
      |> Enum.group_by(fn x -> x.category end)
      |> Enum.filter(fn {_,prods} -> prods |> Enum.all?(fn p -> p.units_in_stock > 0 end) end)
      |> Enum.map(fn {cat, prods} -> %{category: cat, products: prods} end)

    assert 5 == length(product_groups)
    first_group = product_groups |> Enum.at(0)
    assert first_group.category == "Beverages"
    assert 12 == length(first_group.products)
  end
end
