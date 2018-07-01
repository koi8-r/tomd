defmodule Tomd.Api.ResponseHelper do
  def ok_text(conn, body), do: ok(conn, body)

  defp ok(conn, body), do: ok(conn, body, "text/plain")

  defp ok conn, body, ct do
    conn
    |> Plug.Conn.put_resp_content_type(ct, "utf-8")
    |> Plug.Conn.send_resp(200, body)
  end
end
