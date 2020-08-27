defmodule TextClient.Mover do
  @moduledoc """
  This module pass the user guess to the server implemented by the Hangman app
  """
  alias TextClient.State

  def move(state = %State{}) do
    gs = Hangman.make_move(state.game_service, state.guess)

    %State{
      state
      | game_service: gs,
        tally: Hangman.tally(gs)
    }
  end
end
