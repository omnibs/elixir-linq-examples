defmodule ElixirLinqExamples.Util do
	def are_anagrams(x, y) do
		String.downcase(x) != String.downcase(y) && normalize(x) == normalize(y)
	end
	defp normalize(x) do
		x |> String.downcase |> String.codepoints |> String.sort
	end

  def average(list) do
    sum_and_count = list
      |> Enum.reduce({0,0}, fn x, {acc, count} -> {acc + x, count + 1} end)
    elem(sum_and_count, 0) / elem(sum_and_count, 1)
  end
end