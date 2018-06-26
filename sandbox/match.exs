"10"
|> Integer.parse
|> case do
  {v, ""} when v > 0 -> v
  _ -> :error
end
|> IO.puts



with {a, b} <- {:ok, 10},
     {:ok, v} <- {a, :error},
     {:ok, y} <- {v, "Z"},
     {_, _, _,} <- "Dont reach!"
do
  {a, b, v, y}
else
  {:error, "Z"} -> :z_error
  _ -> :unknown_error
end
|> (&(if is_tuple(&1)
      do Tuple.to_list(&1)
      else List.wrap(&1)
      end)).()
|> Enum.join(", ")
|> IO.puts
