defmodule ElixirLinqExamples.Set do
  use ExUnit.Case

  import ElixirLinqExamples.Data
  
  test "linq46: Distinct - 1" do
    factors_of_300 = [2, 2, 3, 5, 5]

    unique_factors = Enum.uniq(factors_of_300)

    # IO.puts "Prime factors of 300:"
    # for f <- unique_factors, do: IO.puts f

    assert [2,3,5] == unique_factors
  end

  test "linq47: Distinct - 2" do
    products = get_product_list()

    category_names = products |> Enum.map(fn x -> x.category end) |> Enum.uniq

    # IO.puts "Category names:"
    # for c <- category_names, do: IO.puts c

    assert 8 == length(category_names)
  end

  test "linq48: Union - 1" do
    numbers_a = [0, 2, 4, 5, 6, 8, 9]
    numbers_b = [1, 3, 5, 7, 8]

    unique_numbers = Set.union(Enum.into(numbers_a, HashSet.new), Enum.into(numbers_b, HashSet.new)) |> Enum.sort

    # IO.puts "Unique numbers from both arrays:"
    # for n <- unique_numbers, do: IO.puts n

    assert 10 == length(unique_numbers)
  end

  test "linq49: Union - 2" do
    products = get_product_list()
    customers = get_customer_list()

    product_first_chars = products 
    |> Enum.map(fn x -> String.at(x.product_name, 0) end)

    customer_first_chars = customers
    |> Enum.map(fn x -> String.at(x.name, 0) end)

    unique_first_chars = Set.union(Enum.into(product_first_chars, HashSet.new), Enum.into(customer_first_chars, HashSet.new)) |> Enum.sort

    # IO.puts "Unique first letters from Product names and Customer names:"
    # for c <- unique_first_chars, do: IO.puts c

    assert 24 == length(unique_first_chars)
  end

  test "linq50: Intersect - 1" do
    numbers_a = [0, 2, 4, 5, 6, 8, 9]
    numbers_b = [1, 3, 5, 7, 8]

    common_numbers = Set.intersection(Enum.into(numbers_a, HashSet.new), Enum.into(numbers_b, HashSet.new)) |> Enum.sort

    # IO.puts "Common numbers shared by both arrays:"
    # for n <- common_numbers, do: IO.puts n

    assert 2 == length(common_numbers)
  end

  test "linq51: Intersect - 2" do
    products = get_product_list()
    customers = get_customer_list()

    product_first_chars = products 
    |> Enum.map(fn x -> String.at(x.product_name, 0) end)

    customer_first_chars = customers
    |> Enum.map(fn x -> String.at(x.name, 0) end)

    common_first_chars = Set.intersection(Enum.into(product_first_chars, HashSet.new), Enum.into(customer_first_chars, HashSet.new)) |> Enum.sort

    # IO.puts "Common first letters from Product names and Customer names:"
    # for c <- common_first_chars, do: IO.puts c

    assert 19 == length(common_first_chars)
  end

  test "linq52: Except - 1" do
    numbers_a = [0, 2, 4, 5, 6, 8, 9]
    numbers_b = [1, 3, 5, 7, 8]

    a_only_numbers = Set.difference(Enum.into(numbers_a, HashSet.new), Enum.into(numbers_b, HashSet.new)) |> Enum.sort

    # IO.puts "Numbers in first array but not second array:"
    # for n <- a_only_numbers, do: IO.puts n

    assert 5 == length(a_only_numbers)
  end

  test "linq53: Except - 2" do
    products = get_product_list()
    customers = get_customer_list()

    product_first_chars = products 
    |> Enum.map(fn x -> String.at(x.product_name, 0) end)

    customer_first_chars = customers
    |> Enum.map(fn x -> String.at(x.name, 0) end)

    product_only_first_chars = Set.difference(Enum.into(product_first_chars, HashSet.new), Enum.into(customer_first_chars, HashSet.new)) |> Enum.sort

    # IO.puts "First letters from Product names, but not from Customer names:"
    # for c <- product_only_first_chars, do: IO.puts c

    assert 3 == length(product_only_first_chars)
  end

end