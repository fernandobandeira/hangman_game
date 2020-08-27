defmodule TextClient.Interact do
  @moduledoc """
  This module launches a new game and initialize the state
  """
  alias TextClient.{Player, State}

  def start do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end
