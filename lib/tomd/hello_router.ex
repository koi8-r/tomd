defmodule Tomd.HelloRouter do
  use Plug.Router

  plug :match
  plug :dispatch
  plug :__plug__, %{foo: :bar}

  defp __plug__ conn, _opts do
    conn
  end

  get "/" do
    conn |> send_resp(200, "hello")
  end

  match _ do
    conn |> send_resp(405, "Method not allowed")
  end
end
