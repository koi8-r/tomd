defmodule Tomd.Plug.Fuuuuu do

  require Logger


  def init(opts), do: opts

  def call(%Plug.Conn{} = conn, _opts)
  do
    conn |> Plug.Conn.send_resp(500, __MODULE__
                                     |> to_string
                                     |> String.capitalize)
         |> Plug.Conn.halt
  end

end
