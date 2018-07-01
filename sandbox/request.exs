defmodule User do
    defstruct [:id, :login]
    @type t :: %User{id: integer, login: String.t}
end


defmodule Request do
    def read(conn),   do:
        if 0 < length(String.to_charlist conn),
            do: {:ok, conn},
            else: {:error, "Empty string error"}

    def decode(body), do:
        if body === "Hello, World!",
            do: {:ok, body},
            else: {:error, "Error, 'Hello, World!' string expected"}

    @spec parse(User.t) :: User.t
    def parse(user) do
        user
    end

end


"Hello, World!"
  |> Request.read
  |> elem(1)
  |> Request.decode



with  {:ok, body} <- Request.read(""),
      {:ok, body} <- Request.decode(body)
do
      {:ok, body}
else
      {_, reason} -> {:error, reason}
end
  |> IO.inspect
