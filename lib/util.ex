defmodule ElixirLinqExamples.Util do
	def are_anagrams(x, y) do
		String.downcase(x) != String.downcase(y) && normalize(x) == normalize(y)
	end
	defp normalize(x) do
		x |> String.downcase |> String.codepoints |> String.sort
	end

  def average(list) do
    {sum, count} = list
      |> Enum.reduce({0,0}, fn x, {acc, count} -> {acc + x, count + 1} end)
    sum / count
  end

  def left_outer_join(list1, list2, equality, mapper1 \\ & &1, mapper2 \\ & &1) do
    Enum.reduce(list1, [], fn a, acc -> 
      matches = list2 |> Enum.filter(fn b -> equality.(a,b) end)
      if Enum.empty?(matches) do
        [{mapper1.(a), nil} | acc]
      else
        mapped_a = mapper1.(a);
        entries = matches |> Enum.map(& {mapped_a, mapper2.(&1)})
        entries ++ acc
      end
    end) 
      |> Enum.reverse
  end
end