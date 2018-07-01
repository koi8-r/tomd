defmodule Tomd.Plug.Produce do

  require Logger
  alias Plug.Conn


  def init(opts), do: opts

  @doc """
  This is prototype
  """
  # fixme: content-type miss in response
  def call(%Conn{req_headers: headers} = conn, opts)
  do
    Logger.debug "Call plug: " <> to_string(__MODULE__)
    opts |> IO.inspect
    headers |> IO.inspect
    accepted = headers
      |> Enum.find(&(elem(&1, 0) == "accept"))
      |> Kernel.||({"accept", "*/*"})
      |> elem(1)
      |> String.split(",") |> Enum.map(&(String.trim(&1)))
      |> Enum.find_value(&(&1 in opts))
    unless accepted do
      conn
        |> Conn.send_resp(406, "Not Acceptable")
        |> Conn.halt
    else
      conn
    end
  end

end
