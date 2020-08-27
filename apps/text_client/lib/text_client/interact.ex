defmodule TextClient.Interact do
  @moduledoc """
  This module launches a new game and initialize the state
  """
  @hangman_server :"hangman@fernandos-mbp"
  alias TextClient.{Player, State}

  def start do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  defp new_game do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end
end
