defmodule ElixirLinqExamples.Conversion do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  test "linq54: ToArray" do
    doubles = [1.7, 2.3, 1.9, 4.1, 2.9];
    
    sorted_doubles = doubles |> Enum.sort(& &1 > &2)

    # IO.puts "Every other double from highest to lowest:"
    # for d <- (sorted_doubles |> Enum.take_every(2)), do: IO.puts d

    assert [4.1, 2.3, 1.7] == (sorted_doubles |> Enum.take_every(2))
  end

  test "linq55: ToList" do
    ## LINQ uses lazy evaluation.
    ## The best comparison here would be using a Stream.
    ## But Stream doesn't have a sort method, 
    ## and it makes sense, since sorting traverses the whole list anyway.
    ## For reference see: http://elixir-lang.org/getting-started/enumerables-and-streams.html

    words = ["cherry", "apple", "blueberry"]

    sorted_words = words |> Enum.sort

    word_list = sorted_words

    # IO.puts "The sorted word list:"
    # for w <- word_list, do: IO.puts w

    assert ["apple", "blueberry", "cherry"] == word_list
  end

  test "linq56: ToDictionary" do
    score_records = [%{name: "Alice", score: 50},
                     %{name: "Bob", score: 40},
                     %{name: "Cathy", score: 45}]

    score_records_dict = score_records |> Enum.map(fn x -> {x.name, x.score} end) |> Enum.into(%{})

    ## If using Erlang 17, use HashDicts because https://gist.github.com/BinaryMuse/bb9f2cbf692e6cfa4841
    ## score_records_dict = score_records |> Enum.map(fn x -> {x.name, x} end) |> Enum.into(HashDict.new)

    # IO.puts ~s(Bob's Score: #{score_records_dict["Bob"]})

    assert 40 == score_records_dict["Bob"]
  end

  test "linq57: OfType" do
    numbers = [nil, 1.0, "two", 3, "four", 5, "six", 7.0]

    doubles = numbers |> Enum.filter &is_float/1

    # IO.puts "Numbers stored as doubles:"
    # for d <- doubles, do: IO.puts d

    assert [1.0, 7.0] == doubles
  end
end