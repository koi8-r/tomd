defmodule Tomd.Router do
  use Plug.Router
  require Logger

  Logger.debug "Compile root router"

  plug :match
  plug :dispatch

  forward "/hello", to: Tomd.HelloRouter
  forward "/sandbox/api", to: Tomd.Sandbox.Api.Router
  forward "/api/v1", to: Tomd.Api.V1.Router
  forward "/api", to: Tomd.Api.Router

  match _ do
    conn |> send_resp(404, "Not found")
  end
end
