defmodule ElixirLinqExamples.Join do
  use ExUnit.Case

  import ElixirLinqExamples.Data
  import ElixirLinqExamples.Util

  test "linq102: Cross Join" do
    categories = ["Beverages",
      "Condiments",
      "Vegetables",
      "Dairy Products",
      "Seafood"]

    products = get_product_list()

    q = 
      for c <- categories, 
        p <- products, 
        p.category == c, 
        do: %{category: c, product_name: p.product_name}

    # for v <- q, do: IO.puts "#{v.product_name}: #{v.category}"

    assert length(q) < length(products)
  end

  test "linq103: Group Join" do
    categories = ["Beverages",
      "Condiments",
      "Vegetables",
      "Dairy Products",
      "Seafood"]

    products = get_product_list()

    q = for c <- categories,
          {cat, prod} <- Enum.group_by(products, fn x -> x.category end),
          c == cat,
          do: %{category: c, products: prod}

    # for v <- q do
    #   IO.puts v.category <> ":"
    #   for p <- v.products, do: IO.puts "   #{p.product_name}"
    # end

    assert 4 == length(q)
  end

  test "linq104: Cross Join with Group Join" do
    categories = ["Beverages",
      "Condiments",
      "Vegetables",
      "Dairy Products",
      "Seafood"]

    products = get_product_list()

    q = for c <- categories,
          {cat, prods} <- Enum.group_by(products, fn x -> x.category end),
          p <- prods,
          c == cat,
          do: %{category: c, product_name: p.product_name}

    # for v <- q, do: IO.puts "#{v.product_name}: #{v.category}"

    assert length(q) < length(products)
  end

  test "linq105: Left Outer Join" do
    categories = ["Beverages",
      "Condiments",
      "Vegetables",
      "Dairy Products",
      "Seafood"]

    products = get_product_list()

    q = left_outer_join(categories, products, & &1 == &2.category, & &1, & &1.product_name)
      |> Enum.map(fn {cat, prod} -> %{category: cat, product_name: prod || "(No products)"} end)

    # for v <- q, do: IO.puts "#{v.product_name}: #{v.category}"

    assert length(q) < length(products)
  end
end