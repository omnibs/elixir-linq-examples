defmodule ElixirLinqExamples.QueryExecution do
  use ExUnit.Case

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

    ## We use agents to hold mutable state
    {:ok, pid} = Agent.start_link(fn -> numbers end)

    ## And use functions for query reuse
    low_numbers = fn -> Agent.get(pid, & &1) |> Enum.filter(& &1 <= 3) end

    # IO.puts "First run numbers <= 3:"
    # for n <- low_numbers.(), do: IO.puts n

    Agent.update(pid, fn x -> x |> Enum.map(& -&1) end)

    # IO.puts "Second run numbers <= 3:"
    # for n <- low_numbers.(), do: IO.puts n

    assert [-5, -4, -1, -3, -9, -8, -6, -7, -2, 0] == low_numbers.()
  end
end