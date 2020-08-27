defmodule Hangman.Game do
  @moduledoc """
  This module contains the implementation of the Hangman game API
  """
  alias Hangman.Game

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Game{
      letters:
        word
        |> String.codepoints()
    }
  end

  def new_game do
    word_list = Dictionary.start()
    new_game(Dictionary.random_word(word_list))
  end

  def make_move(game = %Game{game_state: state}, _guess) when state in [:won, :lost] do
    game
  end

  def make_move(game = %Game{}, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  def tally(game = %Game{}) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      used: game.used,
      letters:
        game.letters
        |> reveal_guessed(game.used)
    }
  end

  ####################################################################

  defp accept_move(game = %Game{}, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game = %Game{}, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game = %Game{}, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %Game{turns_left: 1}, _not_good_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game = %Game{turns_left: turns_left}, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word), do: "_"

  defp maybe_won(true), do: :won
  defp maybe_won(_didnt_won), do: :good_guess
end
