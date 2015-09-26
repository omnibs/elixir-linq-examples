defmodule ElixirLinqExamples.Util do
	def are_anagrams(x, y) do
		String.downcase(x) != String.downcase(y) && normalize(x) == normalize(y)
	end
	defp normalize(x) do
		x |> String.downcase |> String.codepoints |> String.sort
	end
end