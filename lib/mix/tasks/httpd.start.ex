defmodule Mix.Tasks.Httpd.Start do
  #use Mix.Task


  def run(_) do
    IO.inspect :ok
    # Plug.Adapters.Cowboy.http(Tomd.Router, [], [acceptors: 2])
  end
end
