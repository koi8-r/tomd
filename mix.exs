defmodule Tomd.MixProject do
  use Mix.Project

  def project do [
      app: :tomd,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: [{:cowboy, "== 1.1.2"},
             {:plug, "~> 1.0"},
             {:poison, "~> 3.1"}]
  ] end

  def application do [
      extra_applications: [:logger,
                           :cowboy,
                           :plug],
      mod: {Tomd.Application, []}
  ] end
end
