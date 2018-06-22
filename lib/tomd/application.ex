defmodule Tomd.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Supervisor.Spec.worker(__MODULE__, [], function: :start_server)
    ]

    opts = [strategy: :one_for_one, name: Tomd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_server do
    {:ok, _} = Plug.Adapters.Cowboy.http(Tomd.Router, [], [acceptors: 2])
  end
end
