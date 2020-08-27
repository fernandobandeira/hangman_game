defmodule Hangman.Application do
  @moduledoc """
  This module starts a Hangman application on its own separate process
  """
  use Application

  def start(_type, _args) do
    options = [
      name: Hangman.Supervisor,
      strategy: :one_for_one
    ]

    DynamicSupervisor.start_link(options)
  end
end
