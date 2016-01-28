defmodule ElixirLinqExamples.Aggregate do
  use ExUnit.Case

  import ElixirLinqExamples.Data
  import ElixirLinqExamples.Util

  test "linq73: Count - Simple" do
    factors_of_300 = [2, 2, 3, 5, 5]

    unique_factors = factors_of_300
    |> Enum.uniq
    |> Enum.count

    # IO.puts "There are #{unique_factors} unique factors of 300."

    assert 3 == unique_factors
  end

  test "linq74: Count - Conditional" do
    require Integer
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    odd_numbers = numbers |> Enum.count(fn x -> Integer.is_odd(x) end)

    # IO.puts "There are #{odd_numbers} odd numbers in the list."

    assert 5 == odd_numbers
  end

  test "linq76: Count - Nested" do
    customers = get_customer_list()

    order_counts = customers |> Enum.map(fn x -> %{customer_id: x.id, order_count: x.orders |> Enum.count } end)

    # IO.inspect order_counts

    assert 6 == hd(order_counts).order_count
  end

  test "linq77: Count - Grouped" do
    products = get_product_list()

    category_counts = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} -> %{category: cat, product_count: prods |> Enum.count} end)

    #IO.inspect category_counts

    assert 12 == hd(category_counts).product_count
  end

  test "linq78: Sum - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    num_sum = Enum.sum(numbers)

    # IO.puts "The sum of the numbers is #{num_sum}"

    assert 45 = num_sum
  end

  test "linq79: Sum - Projection" do
    words = ["cherry", "apple", "blueberry"]

    total_chars = words
    |> Enum.map(&String.length/1)
    |> Enum.sum

    # IO.puts "There are a total of #{total_chars} characters in these words."

    assert 20 == total_chars
  end

  test "linq80: Sum - Grouped" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      %{
        category: cat,
        total_units_in_stock: prods
        |> Enum.map(fn p -> p.units_in_stock end)
        |> Enum.sum
      }
    end)

    # IO.inspect categories

    assert 559 == hd(categories).total_units_in_stock
  end

  test "linq81: Min - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    min_num = Enum.min(numbers)

    # IO.puts "The minimum number is #{min_num}"

    assert 0 == min_num
  end

  test "linq82: Min - Projection" do
    words = ["cherry", "apple", "blueberry"]

    shortest_word = words |> Enum.map(&String.length/1) |> Enum.min

    # IO.puts "The shortest word is #{shortest_word} characters long."

    assert 5 == shortest_word
  end

  test "linq83: Min - Grouped" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      %{
        category: cat,
        cheapest_price: prods
        |> Enum.map(fn p -> p.unit_price end)
        |> Enum.min
      }
    end)

    # IO.inspect categories

    assert 4.5 == hd(categories).cheapest_price
  end

  test "linq84: Min - Elements" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      min_price = prods
      |> Enum.map(fn p -> p.unit_price end)
      |> Enum.min

      %{
        category: cat,
        cheapest_products: prods
        |> Enum.filter(fn p -> p.unit_price == min_price end)
      }
    end)

    # IO.inspect categories

    assert 24 == categories |> hd |> Map.get(:cheapest_products) |> hd |> Map.get(:product_id)
  end

  test "linq85: Max - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    max_num = Enum.max(numbers)

    # IO.puts "The maximum number is #{max_num}"

    assert 9 == max_num
  end

  test "linq86: Max - Projection" do
    words = ["cherry", "apple", "blueberry"]

    longest_word = words |> Enum.map(&String.length/1) |> Enum.max

    # IO.puts "The longest word is #{longest_word} characters long."

    assert 9 == longest_word
  end

  test "linq87: Max - Grouped" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      %{
        category: cat,
        most_expensive_price: prods
        |> Enum.map(fn p -> p.unit_price end)
        |> Enum.max
      }
    end)

    # IO.inspect categories

    assert 263.5 == hd(categories).most_expensive_price
  end

  test "linq88: Max - Elements" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      max_price = prods
      |> Enum.map(fn p -> p.unit_price end)
      |> Enum.max

      %{
        category: cat,
        most_expensive_products: prods
        |> Enum.filter(fn p -> p.unit_price == max_price end)
      }
    end)

    # IO.inspect categories

    assert 38 == categories |> hd |> Map.get(:most_expensive_products) |> hd |> Map.get(:product_id)
  end

  test "linq89: Average - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    average_num = numbers |> average()

    # IO.puts "The average number is #{average_num}"

    assert 4.5 == average_num
  end

  test "linq90: Average - Projection" do
    words = ["cherry", "apple", "blueberry"]

    average_length = words
    |> Enum.map(&String.length/1)
    |> average()

    # IO.puts "Average word length is #{average_length} characters."

    assert 20/3 == average_length
  end

  test "linq91: Average - Grouped" do
    products = get_product_list()

    categories = products
    |> Enum.group_by(fn x -> x.category end)
    |> Enum.map(fn {cat, prods} ->
      %{
        category: cat,
        average_price: prods
        |> Enum.map(fn p -> p.unit_price end)
        |> average
      }
    end)

    # IO.inspect categories

    assert 37.979166666666664 == hd(categories).average_price
  end

  test "linq92: Aggregate - Simple" do
    doubles = [1.7, 2.3, 1.9, 4.1, 2.9]

    product = doubles |> Enum.reduce(fn x, acc -> x * acc end)

    # IO.puts "Total product of all numbers: #{product}"

    assert 88.33080999999999 == product
  end

  test "linq93: Aggregate - Seed" do
    startBalance = 100.0

    attempted_withdrawals = [20, 10, 40, 50, 10, 70, 30]

    end_balance = attempted_withdrawals
    |> Enum.reduce(startBalance, fn next_withdrawal, balance ->
      if next_withdrawal <= balance, do: balance - next_withdrawal, else: balance
    end)

    # IO.puts "Ending balance: #{end_balance}"

    assert 20 == end_balance
  end
end
