defmodule ElixirLinqExamples.Ordering do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq28: OrderBy - Simple 1" do
    words = ["cherry", "apple", "blueberry"]
    sorted_words = words |> Enum.sort

    # IO.puts "The sorted list of words:"
    # for w <- words, do: IO.puts w

    assert ["apple", "blueberry", "cherry"] == sorted_words
  end

  test "linq29: OrderBy - Simple 2" do
    words = ["cherry", "apple", "blueberry"]
    sorted_words = words |> Enum.sort_by(&String.length/1)

    # IO.puts "The sorted list of words (by length):"
    # for w <- words, do: IO.puts w

    assert ["apple", "cherry", "blueberry"] == sorted_words
  end

  test "linq30: OrderBy - Simple 3" do
    products = get_product_list()

    sorted_products = products 
      |> Enum.sort_by(fn x -> x.product_name end)

    # IO.inspect sorted_products

    assert 17 == hd(sorted_products).product_id
  end

  test "linq31: OrderBy - Comparer" do
    words = ["aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry"];

    sorted_words = words |> Enum.sort_by &String.downcase/1

    # IO.inspect sorted_words

    assert "AbAcUs" == hd(sorted_words)
  end

  test "linq32: OrderByDescending - Simple 1" do
    doubles = [1.7, 2.3, 1.9, 4.1, 2.9]

    sorted_doubles = doubles |> Enum.sort |> Enum.reverse

    # IO.puts "The doubles from highest to lowest:"
    # for d <- sorted_doubles, do: IO.puts d

    assert 4.1 == hd(sorted_doubles)
  end

  test "linq33: OrderByDescending - Simple 2" do
    products = get_product_list()

    sorted_products = products |> Enum.sort &(&1.units_in_stock >= &2.units_in_stock)

    # IO.inspect sorted_products

    assert 75 == hd(sorted_products).product_id
  end

  test "linq34: OrderByDescending - Comparer" do
    words = ["aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry"]

    sorted_words = words |> Enum.sort &(String.downcase(&1) >= String.downcase(&2))

    # IO.inspect sorted_words

    assert "ClOvEr" == hd(sorted_words)
  end

  test "linq35: ThenBy - Simple" do
    digits = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    sorted_digits = digits 
      |> Enum.sort 
      |> Enum.sort_by(fn x -> String.length(x) end)

    # IO.puts "Sorted digits:"
    # for d <- sorted_digits, do: IO.puts d

    assert ["one", "six", "two", "five", "four", "nine", "zero", "eight", "seven", "three"] == sorted_digits
  end

  test "linq36: ThenBy - Comparer" do
    words = ["aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry"]

    sorted_words = words 
      |> Enum.sort_by(&String.downcase/1) 
      |> Enum.sort_by(&String.length/1)

    # IO.inspect sorted_words

    assert ["aPPLE", "AbAcUs", "bRaNcH", "cHeRry", "ClOvEr", "BlUeBeRrY"] == sorted_words
  end

  test "linq37: ThenByDescending - Simple" do
    products = get_product_list()

    sorted_products = products 
      |> Enum.sort(fn x,y -> x.unit_price >= y.unit_price end)
      |> Enum.sort_by(&(&1.category))

    # IO.inspect sorted_products

    assert 38 == hd(sorted_products).product_id
  end

  test "linq38: ThenByDescending - Comparer" do
    words = ["aPPLE", "AbAcUs", "bRaNcH", "BlUeBeRrY", "ClOvEr", "cHeRry"]

    sorted_words = words
      |> Enum.sort(fn x,y -> String.downcase(x) >= String.downcase(y) end)
      |> Enum.sort_by &(String.length(&1))

    IO.inspect sorted_words

    assert ["aPPLE", "ClOvEr", "cHeRry", "bRaNcH", "AbAcUs", "BlUeBeRrY"] == sorted_words
  end

  test "linq39: Reverse" do
    digits = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    reversed_i_digits = digits
      |> Enum.filter(fn x -> String.at(x, 1) == "i" end)
      |> Enum.reverse

    # IO.puts "A backwards list of the digits with a second character of 'i':"
    # for d <- reversed_i_digits, do: IO.puts d

    assert ["nine", "eight", "six", "five"] == reversed_i_digits
  end
end