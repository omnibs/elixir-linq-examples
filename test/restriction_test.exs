defmodule ElixirLinqExamples.Restriction do
  use ExUnit.Case

  import ElixirLinqExamples.Data


  test "linq1: Where - Simple 1" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    low_nums = numbers |> Enum.filter(fn x -> x < 5 end)

    #IO.puts "Numbers < 5:"
    #for n <- low_nums, do: IO.puts n

    assert low_nums == [4,1,3,2,0]
  end

  test "linq2: Where - Simple 2" do
    products = get_product_list()

    sold_out_products =
      products
      |> Enum.filter(fn x -> x.units_in_stock == 0 end)

    #IO.puts "Sold out products:"

    assert Enum.count(sold_out_products) == 5
    first_product = %Product{category: "Condiments", product_id: 5, product_name: "Chef Anton's Gumbo Mix", unit_price: 21.35, units_in_stock: 0}
    assert sold_out_products |> Enum.at(0) == first_product

    #for n <- sold_out_products, do: IO.puts "#{n.product_name} is sold out!"
  end

  test "linq3: Where - Simple 3" do
    products = get_product_list()

    in_stock_and_more_than_3 =
      products
      |> Enum.filter(fn x -> x.units_in_stock > 0 && x.unit_price > 3.00 end)

    first = in_stock_and_more_than_3 |> Enum.at(0)
    assert in_stock_and_more_than_3 |> Enum.count == 71
    assert first == %Product{category: "Beverages", product_id: 1, product_name: "Chai", unit_price: 18.0, units_in_stock: 39}
  end

  test "linq4: Where - Drilldown" do
    customers = get_customer_list()

    wa_customers = customers |> Enum.filter(fn x -> x.region == "WA" end)

    # IO.puts "Customers from Washington and their orders:"
    # for customer <- wa_customers do
    #   IO.puts "Customer #{customer["id"]}: #{customer["name"]}"
    #   for order <- customer["orders"]["order"], do: IO.puts "\tOrder #{order["id"]}: #{order["orderdate"]}"
    # end

    assert 3 == length(wa_customers)
  end

  test "linq5: Where - Indexed" do
    digits = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    short_digits = digits
      |> Stream.with_index
      |> Stream.filter(fn {entry, index} -> String.length(entry) < index end)
      |> Stream.map(fn {x,_} -> x end)
      |> Enum.to_list

    #for n <- short_digits, do: IO.puts "The word #{n} is shorter than its value"

    assert length(short_digits) == 5
  end
end
