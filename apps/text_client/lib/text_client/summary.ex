defmodule TextClient.Summary do
  @moduledoc """
  This module prints a summary to the player of the current state
  """
  alias TextClient.State

  def display(state = %State{tally: tally}) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Letters used: #{Enum.join(tally.used, " ")}\n",
      "Guesses left: #{tally.turns_left}\n"
    ])

    state
  end
end
