defmodule Tomd.Api.V1.Router do
  @moduledoc """
  plugs execution
  |
  | :accepts
  | :content-type
  | :decode
  | :process
  | :encode
  ▼
  """


  use Plug.Router
  require Logger
  import Tomd.Api.ResponseHelper
  alias Tomd.Api.V1.Model

  plug Tomd.Plug.Produce, ["application/json",
                           "*/json",
                           "*/*"]
  plug Tomd.Plug.Consume, ["application/json"]
  plug :match
  plug :deserialize  #  recv
  # plug :validate
  plug :dispatch
  plug :serialize  #  send

  def deserialize conn, _ do
    Logger.debug "Deserialize"
    {:ok, body} = conn |> Plug.Conn.read_body |> elem(1) |> Poison.decode(as: %Model.Todo{})
    # {:error, _}

    conn |> set_body(body)
  end

  def serialize conn, _ do
    IO.puts "Serialize"
    {:ok, body} = conn |> get_body |> Poison.encode
    conn |> Plug.Conn.send_resp(get_status(conn) || 200, body)  # state: :sent, status: 201
  end

  defp get_status(conn), do: conn.private[:tomd_status]
  defp set_status(conn, code), do: Plug.Conn.put_private(conn, :tomd_status, code)  # fixme: Conn.set_status and Conn.send_resp/1
  defp get_body(conn), do: conn.private[:tomd_body]
  defp set_body(conn, body), do: Plug.Conn.put_private(conn, :tomd_body, body)

  @root_path "/"  # todo: 405 http error auto match macro create

  get @root_path do
    conn |> ok_text("OK")
  end

  post @root_path do
    conn |> set_status(201) |> set_body("Success")
  end

  post "/coffee" do
      import Plug.Conn
      import Poison

      {res, body} =
      with  {:ok, body, _} <- read_body(conn),
            {:ok, model}   <- decode(body, as: %Model.Todo{}),
            {:ok, body}    <- encode(model)
      do
            {201, body}
      else
            {_, _} -> {400, "Error during parse request body"}
      end

      send_resp(conn, res, body) |> halt
  end

  match @root_path do
    conn |> send_resp(405, "Method not allowed")
  end


  match _ do
    conn |> send_resp(404, "Not found")
  end

end
