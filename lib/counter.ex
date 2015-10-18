defmodule Counter do
  def start_link(value) do
    Agent.start_link(fn -> value end)
  end

  def get(pid) do
    Agent.get(pid, fn x -> x end)
  end

  def inc(pid) do
    Agent.get_and_update(pid, fn x -> {x + 1, x + 1} end)
  end
end