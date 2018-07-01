defmodule Tomd.Api.Router do
  use Plug.Router
  # require Logger
  import Tomd.Api.ResponseHelper

  defmodule User do
    defstruct [:id, :login]
  end


  #  pipeline :api do
  #  end
  #  plug :accepts, ["text"]
  #  plug Plug.Logger
  # plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  get "/ip" do
    conn.private.plug_route |> IO.inspect(label: "Conn private for ip res")
    ip = conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    conn |> ok_text(ip)
  end

  match "/ip" do
    conn |> send_resp(405, "Method not allowed")
  end

  post "/" do
    # user = conn.body_params
    # conn |> send_resp(201, Poison.encode!(user))
    # Plug.Adapters.Cowboy.Conn
    body = conn |> Plug.Conn.read_body
    body |> IO.inspect(label: "body")
    Poison.decode(body, as: %User{}) |> IO.inspect(label: "decoded")
    conn |> IO.inspect(label: (__MODULE__ |> to_string) <> " POST body")
    conn |> send_resp(201, "OK")
  end

  match _ do
    conn |> send_resp(404, "Not found")
  end

end
