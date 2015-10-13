defmodule ElixirLinqExamples.QueryExecution do
  use ExUnit.Case

  import ElixirLinqExamples.Data

  setup do
    {:ok, pid} = Counter.start_link(0)
    {:ok, counter_agent: pid}
  end

  test "linq99: Deferred Execution", %{counter_agent: pid} do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    ## Since Elixir's variables are immutable
    ## I'm using an Agent to hold state
    ## and mimic the behavior seen in LINQ
    q = numbers |> Stream.map(fn _ -> Counter.inc(pid) end)

    values = "#{Counter.get(pid)} #{Enum.count(q)} #{Counter.get(pid)}" 
    #  |> IO.puts

    assert "0 10 10" == values
  end

  test "linq100: Immediate Execution", %{counter_agent: pid} do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    ## Since Elixir's variables are immutable
    ## I'm using an Agent to hold state
    ## and mimic the behavior seen in LINQ
    q = numbers |> Enum.map(fn _ -> Counter.inc(pid) end)

    values = "#{Counter.get(pid)} #{Enum.count(q)} #{Counter.get(pid)}" 
    #  |> IO.puts

    assert "10 10 10" == values
  end

  test "linq101: Query Reuse" do
    numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0]

    ## Still trying to solve this one
  end
end