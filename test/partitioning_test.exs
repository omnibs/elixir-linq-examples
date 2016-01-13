defmodule ElixirLinqExamples.Partitioning do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq20: Take - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];

    first_3_numbers = numbers |> Enum.take(3)

    # IO.puts "First 3 numbers:"
    # for n <- first_3_numbers, do: IO.puts n

    assert 3 == length(first_3_numbers)
  end

  test "linq21: Take - Nested" do
    customers = get_customer_list()

    first_3_wa_orders = 
      (for c <- customers,
          o <- c.orders,
          c.region == "WA",
          do: %{customer_id: c.id, order_id: o.id, order_date: o.orderdate})
      |> Enum.take(3)

    # IO.puts "First 3 orders in WA:"
    # for o <- first_3_wa_orders, do: IO.inspect(o)

    assert 3 == length(first_3_wa_orders)
  end

  test "linq22: Skip - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    all_but_first_4_numbers = numbers |> Enum.drop(4)

    # IO.puts "All but first 4 numbers:"
    # for n <- numbers, do: IO.puts n

    assert 6 == length(all_but_first_4_numbers)
  end

  test "linq23: Skip - Nested" do
    customers = get_customer_list()

    wa_orders = 
      for c <- customers,
          o <- c.orders,
          c.region == "WA",
          do: %{customer_id: c.id, order_id: o.id, order_date: o.orderdate}

    all_but_first_2_orders = wa_orders |> Enum.drop(2)

    # IO.puts "All but first 2 orders in WA:"
    # for o <- all_but_first_2_orders, do: IO.inspect o

    assert 17 == length all_but_first_2_orders
  end
  test "linq24: TakeWhile - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    first_numbers_less_than_6 = numbers |> Enum.take_while(fn x -> x < 6 end)

    # IO.puts "First numbers less than 6:"
    # for n <- first_numbers_less_than_6, do: IO.puts n

    assert 4 == length(first_numbers_less_than_6)
  end

  test "linq25: TakeWhile - Indexed" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    first_small_numbers = numbers 
      |> Enum.with_index
      |> Enum.take_while(fn {n, index} -> n >= index end)
      |> Enum.map(fn {x,_} -> x end)

    # IO.puts "First numbers not less than their position:"
    # for n <- first_small_numbers, do: IO.puts n

    assert 2 == length(first_small_numbers)
  end

  test "linq26: SkipWhile - Simple" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    all_but_first_3_numbers = numbers |> Enum.drop_while(fn x -> rem(x, 3) != 0 end)

    # IO.puts "All elements starting from first element divisible by 3:"
    # for n <- all_but_first_3_numbers, do: IO.puts n

    assert 7 == length(all_but_first_3_numbers)
  end

  test "linq27: SkipWhile - Indexed" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    later_numbers = numbers 
      |> Enum.with_index
      |> Enum.drop_while(fn {n, index} -> n >= index end)
      |> Enum.map(fn {x,_} -> x end)

    # IO.puts "All elements starting from first element less than its position:"
    # for n <- later_numbers, do: IO.puts n

    assert 8 == length(later_numbers)
  end
end