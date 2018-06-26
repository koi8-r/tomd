defmodule Tomd.Api.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn |> send_resp(200, "api")
  end

  get "/myip" do
    conn.private.plug_route |> IO.inspect(label: "Conn private for myip res")
    ip = conn.remote_ip |> Tuple.to_list |> Enum.join(".")
    conn |> ok(ip, "text/plain")
  end

  match "/myip" do
    # raise MethodNotXAllowedError
    conn |> send_resp(405, "Method not allowed")
  end

  match _ do
    # __MODULE__ |> IO.inspect
    conn.private.plug_route |> IO.inspect(label: "Conn private")
    conn |> send_resp(404, "Not found")
  end

  defp ok conn, body, ct = "text/plain" do
    conn
    |> put_resp_content_type(ct, "utf-8")
    |> send_resp(200, body)
  end
end

defmodule MethodNotAllowedError do
  defexception message: "Method not allowed", plug_status: 405
end
