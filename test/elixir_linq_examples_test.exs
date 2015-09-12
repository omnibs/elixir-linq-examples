defmodule ElixirLinqExamplesTest do
  use ExUnit.Case

  import ElixirLinqExamples.Data


  test "linq1: Where - Simple 1" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    low_nums = numbers |> Enum.filter(fn x -> x < 5 end)

    IO.puts "Numbers < 5:"
    for n <- low_nums, do: IO.puts n

    assert low_nums == [4,1,3,2,0]
  end

  test "linq2: Where - Simple 2" do
    products = get_product_list()
    
    sold_out_products = 
      products 
      |> Enum.filter(fn x -> x.units_in_stock == 0 end)

    IO.puts "Sold out products:"

    for n <- sold_out_products, do: IO.puts "#{n.product_name} is sold out!"
  end

  test "linq3: Where - Simple 3" do
    products = get_product_list()
    
    sold_out_products = 
      products 
      |> Enum.filter(fn x -> x.units_in_stock > 0 && x.unit_price > 3.00 end)

    IO.puts "In-stock products that cost more than 3.00:"

    for n <- sold_out_products, do: IO.puts "#{n.product_name} is in stock and costs more than 3.00!"
  end
end
