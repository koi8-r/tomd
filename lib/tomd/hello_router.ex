defmodule Tomd.Plug do
  require Logger


  def init opts do
    opts
  end

  def call conn, _opts do
    Logger.debug "Call Tomd.Plug"
    conn |> Plug.Conn.put_resp_header("X-Header", "example")
  end

end


defmodule Tomd.HelloRouter do
  use Plug.Router

  plug Tomd.Plug
  plug :match
  plug :dispatch
  plug :fn_plug, %{foo: :bar}

  def fn_plug conn, _opts do
    conn
  end

  get "/" do
    conn |> send_resp(200, "hello")
  end

  match _ do
    conn |> send_resp(405, "Method not allowed")
  end
end
