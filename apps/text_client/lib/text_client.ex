defmodule TextClient do
  @moduledoc """
  This module provides the entrypoint of the Text Client interface for the Hangman Game
  """

  alias TextClient.Interact
  defdelegate start(), to: Interact
end
