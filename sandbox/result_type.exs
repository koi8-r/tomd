defmodule ResultType do

  def api_call(payload) do
    payload |> IO.inspect(label: "api_call arg")
    case payload do
      3 -> :error
      :error -> :error
      _ -> payload + 1
    end
  end

  def map result, fun do
    # 1 | 5
    result |> IO.inspect(label: "map arg")
    case result do
      {:ok, value} -> {:ok, fun.(value)}
      error -> error
    end
  end

  def chain result, fun do
    with
      {:ok, val_a} <- result,
      {:ok, val_b} <- fun.(val_a)
    do
      {:ok, val_b}
    else
      error -> error
  end
end


alias ResultType, as: R

1
|> R.api_call
|> R.api_call
|> R.api_call
|> R.api_call
|> R.api_call
|> IO.puts


# with statement
# todo

{:ok, "hello"}
|> R.map(&String.upcase/1)
|> R.map(fn _ -> "error" end)
|> R.map(&String.downcase/1)
|> Kernel.elem(1)
|> IO.inspect(label: "result")
