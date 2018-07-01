defmodule Tomd.Plug.Consume do

  require Logger
  alias Plug.Conn


  def init(opts), do: opts

  @doc """
  This is prototype
  """
  def call(%Conn{req_headers: headers} = conn, opts)
  do
    Logger.debug "Call plug: " <> to_string(__MODULE__)
    opts |> IO.inspect
    headers |> IO.inspect
    ct = headers
      |> Enum.find(&(elem(&1, 0) == "content-type"))
      |> Kernel.||({"content-type", "application/octet-stream"})
      |> elem(1)
      |> String.split(",") |> Enum.map(&(String.trim(&1)))
      |> Enum.find_value(&(&1 in opts))
    unless ct do
      conn
        |> Conn.send_resp(415, "Unsupported Media Type")
        |> Conn.halt
    else
      conn
    end
  end

end
