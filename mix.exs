defmodule Tomd.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do [
      app: :tomd,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: [{:cowboy, "== 1.1.2"},
             {:plug, "~> 1.6"},
             {:poison, "~> 3.1"}]
  ] end

  def application do [
      extra_applications: [:logger,
                           :cowboy,
                           :plug],
      mod: {Tomd.Application, []}
  ] end
end
