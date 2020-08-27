defmodule Dictionary.Application do
  @moduledoc """
  This module starts a Dictionary application on its own separate process
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Dictionary.WordList, [])
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
