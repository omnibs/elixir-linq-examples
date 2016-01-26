defmodule ElixirLinqExamples.Projection do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq6: Select - Simple 1" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
    num_plus_one = numbers |> Enum.map(&(&1+1))

    # IO.puts "Numbers + 1:"
    # for n <- num_plus_one, do: IO.puts n

    assert [6 ,5 ,2 ,4 ,10 ,9 ,7 ,8 ,3 ,1] == num_plus_one
  end

  test "linq7: Select - Simple 2" do
    products = get_product_list()

    product_names = products |> Enum.map(&(&1.product_name))

    # IO.puts "Product Names:"
    # for n <- product_names, do: IO.puts n

    assert Enum.all?(product_names, &is_binary/1)
  end

  test "linq8: Select - Transformation" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
    strings = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};

    text_nums = numbers |> Enum.map(&(elem(strings,&1)))

    # IO.puts "Number strings:"
    # for n <- text_nums, do: IO.puts n

    assert Enum.all?(text_nums, &is_binary/1)
  end

  test "linq9: Select - Anonymous Types 1" do
    words = ["aPPLE", "BlUeBeRrY", "cHeRry"]

    upper_lower_words = words |> Enum.map(fn x -> %{lower: String.downcase(x), upper: String.upcase(x)} end)
    first = upper_lower_words |> Enum.at(0)
    assert first == %{lower: "apple", upper: "APPLE"}
  end

  test "linq10: Select - Anonymous Types 2" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]
    strings = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

    digit_odd_evens = numbers |> Enum.map(fn x -> %{digit: elem(strings, x), even: rem(x, 2) == 0} end)

    # for n <- digit_odd_evens, do: IO.puts "The digit #{n.digit} is #{n.even && "even" || "odd"}."

    assert Enum.count(digit_odd_evens, &(&1.even)) == 5
  end

  test "linq11: Select - Anonymous Types 3" do
    products = get_product_list()

    product_infos = products |> Enum.map(fn x -> %{product_name: x.product_name, category: x.category, price: x.unit_price} end)

    # for n <- product_infos, do: IO.puts "#{n.product_name} is in the category #{n.category} and costs #{n.price} per unit."

    assert Enum.all?(product_infos, fn x -> is_number(x.price) end)
  end

  test "linq12: Select - Indexed" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    nums_in_place = numbers
      |> Stream.with_index
      |> Stream.map(fn {x,idx} -> %{num: x, in_place: x == idx} end)
      |> Enum.to_list

    # IO.puts "Number: In-place?"
    # for n <- nums_in_place, do: IO.puts "#{n.num}: #{n.in_place}"

    assert 3 = Enum.count(nums_in_place, fn x -> x.in_place end)
  end

  test "linq13: Select - Filtered" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]
    strings = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

    low_nums = for n <- numbers, n < 5, do: elem(strings, n)

    # IO.puts "Numbers < 5:"
    # for n <- low_nums, do: IO.puts n

    assert 5 = length(low_nums)
  end

  test "linq14: SelectMany - Compound from 1" do
    numbers_a = [0, 2, 4, 5, 6, 8, 9]
    numbers_b = [1, 3, 5, 7, 8]

    pairs = for a <- numbers_a, b <- numbers_b, a < b, do: %{a: a, b: b}

    # IO.puts "Pairs where a < b:"
    # for n <- pairs, do: IO.puts "#{n.a} is less than #{n.b}"

    assert 16 == length(pairs)
  end

  test "linq15: SelectMany - Compound from 2" do
    customers = get_customer_list()

    orders =
      for c <- customers,
          o <- c.orders,
          do: %{customer_id: c.id, order_id: o.id, total: o.total}

    #IO.inspect orders

    assert length(orders) == 830
  end

  test "linq16: SelectMany - Compound from 3" do
    customers = get_customer_list()

    orders =
      for c <- customers,
          o <- c.orders,
          Timex.Date.compare(o.orderdate, Timex.Date.from({1998, 1, 1})) >= 0,
          do: %{customer_id: c.id, order_id: o.id, total: o.total}

    #IO.inspect orders

    assert length(orders) == 270
  end

  test "linq17: SelectMany - from Assignment" do
    customers = get_customer_list()

    orders =
      for c <- customers,
          o <- c.orders,
          elem(Float.parse(o.total), 0) >= 2000.0,
          do: %{customer_id: c.id, order_id: o.id, total: o.total}

    #IO.inspect orders

    assert length(orders) == 185
  end

  test "linq18: SelectMany - Multiple from" do
    customers = get_customer_list()

    cutoff_date = Timex.Date.from({1997, 1, 1})

    orders =
      for c <- customers,
          o <- c.orders,
          c.region == "WA",
          Timex.Date.compare(o.orderdate, cutoff_date) >= 0,
          do: %{customer_id: c.id, order_id: o.id, total: o.total}

    #IO.inspect orders

    assert length(orders) == 17
  end

  test "linq19: SelectMany - Indexed" do
    customers = get_customer_list()

    customerOrders =
      for {c, idx} <- Enum.with_index(customers),
          o <- c.orders,
          do: "Customer ##{idx + 1} has an order with OrderId #{o.id}"

    assert customerOrders |> Enum.at(0) == "Customer #1 has an order with OrderId 10643"
    assert customerOrders |> Enum.at(-1) == "Customer #91 has an order with OrderId 11044"
    assert length(customerOrders) == 830
  end
end
