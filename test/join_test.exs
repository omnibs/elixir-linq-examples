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
          ps <- Enum.group_by(products, fn x -> x.category end),
          c == elem(ps,0),
          do: %{category: c, products: elem(ps, 1)}

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
          ps <- Enum.group_by(products, fn x -> x.category end),
          p <- elem(ps,1),
          c == elem(ps,0),
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
      |> Enum.map(& %{category: elem(&1, 0), product_name: elem(&1, 1) || "(No products)"})

    for v <- q, do: IO.puts "#{v.product_name}: #{v.category}"

    assert length(q) < length(products)
  end
end