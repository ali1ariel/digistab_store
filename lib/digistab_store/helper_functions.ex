defmodule DigistabStore.HelperFunctions do
  def convert_value(value) do
    "R$ #{String.replace(:erlang.float_to_binary(value / 100, decimals: 2), ".", ",")}"
  end

  def cut_string(string, length) do
    string
    |> String.split_at(length)
    |> then(fn {string, out} ->
      string <> if out != "", do: "...", else: ""
    end)
  end

  # verify the match, looking at each possible position in the tag name, return true if it matches.
  def matches?(first, second) do
    String.contains?(
      String.downcase(first),
      String.downcase(second)
    )
  end
end
