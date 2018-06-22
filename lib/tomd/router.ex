defmodule Tomd.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn |> send_resp(200, "home")
  end

  match _ do
    conn |> send_resp(404, "Not found")
  end
end
