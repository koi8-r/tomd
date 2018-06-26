defmodule Tomd.WS do
  alias Plug.Conn, as: Httpd

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> Httpd.put_resp_header("server", "WS")
    |> Httpd.put_resp_content_type("text/plain", "utf-8")
    |> route(conn.method, conn.path_info)
  end


  def route(conn, verb, ["hello", name]) do
    handler = fn
      "GET" -> conn |> Httpd.send_resp(200, "Hello, #{name}!")
      "READ" -> conn |> Httpd.send_resp(200, "Readed, #{name}!")
      _verb -> conn |> Httpd.send_resp(400, "Method not allowed")
    end

    handler.(verb)
  end

  def route(conn, _verb, _path) do
    conn |> Httpd.send_resp(404, "Not found")
  end
end
