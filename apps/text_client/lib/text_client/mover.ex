defmodule TextClient.Mover do
  alias TextClient.State

  def move(state = %State{}) do
    { gs, tally } = Hangman.make_move(state.game_service, state.guess)
    %State{
      state |
      game_service: gs,
      tally: Hangman.tally(gs)
    }
  end
end
