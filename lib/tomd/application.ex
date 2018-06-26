defmodule Tomd.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Supervisor.Spec.worker(__MODULE__, [], function: :start_server),
      Supervisor.Spec.worker(__MODULE__, [], function: :start_ws, id: :ws),
      # Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Tomd.Router, options: [port: 4001])
    ]

    opts = [strategy: :one_for_one, name: Tomd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_server do
    {:ok, _} = Plug.Adapters.Cowboy.http(Tomd.Router, [], [acceptors: 2])
  end

  def start_ws do
    {:ok, _} = Plug.Adapters.Cowboy.http(Tomd.WS, [], port: 4001)
  end
end
