defmodule RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Tomd.Router.init([])

  test "test 200" do
    conn = conn(:get, "/hello") |> Tomd.Router.call(@opts)

    assert {conn.state, conn.status, conn.resp_body}
       === {:sent, 200, "hello"}
  end

  test "test 404" do
    conn = conn(:get, "/not/exists/path") |> Tomd.Router.call(@opts)
    assert {conn.state, conn.status} === {:sent, 404}
  end

  test "test 405" do
    conn = conn(:post, "/hello") |> Tomd.Router.call(@opts)
    assert {conn.state, conn.status} === {:sent, 405}
  end
end
