defmodule Tomd.Router do
  use Plug.Router
  require Logger

  Logger.debug "Compile root router"

  plug :match
  plug :dispatch

  forward "/hello", to: Tomd.HelloRouter
  forward "/api", to: Tomd.Api.Router
  
  match _ do
    conn |> send_resp(404, "Not found")
  end
end
