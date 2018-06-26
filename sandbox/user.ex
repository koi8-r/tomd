defmodule User do

  fields = [:uid, :login]
  @enforce_keys fields

  defstruct fields

  def validate self do
    Map.keys(self) |> Enum.each(fn f -> IO.puts(f <> Map.get(self, f)) end)
  end
end
