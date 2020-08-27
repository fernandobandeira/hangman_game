defmodule Hangman do
  @moduledoc """
  This module provides a public API for the Hangman Game implementation
  """
  alias Hangman.Game
  defdelegate new_game(), to: Game
  defdelegate tally(game), to: Game

  def make_move(game, guess) do
    game = Game.make_move(game, guess)
    {game, tally(game)}
  end
end
