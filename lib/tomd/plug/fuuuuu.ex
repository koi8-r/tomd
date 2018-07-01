defmodule Tomd.Plug.Fuuuuu do

  require Logger


  def init(opts), do: opts

  def call(%Plug.Conn{} = conn, _opts)
  do
    Logger.warn "Call " <> to_string(__MODULE__)
    conn |> Plug.Conn.send_resp(500, "Fuuuuu")
         |> Plug.Conn.halt
  end

end
