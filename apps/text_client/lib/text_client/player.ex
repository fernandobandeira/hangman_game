defmodule TextClient.Player do
  @moduledoc """
  This module aggregates all of the game implementation and handles the game state
  """

  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost.")
  end

  def play(state = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(state, "Good guess!")
  end

  def play(state = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(state, "Sorry, that isn't in the word.")
  end

  def play(state = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(state, "You've already used that letter.")
  end

  def play(state = %State{}) do
    continue(state)
  end

  defp continue(state) do
    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  defp continue_with_message(state, msg) do
    IO.puts(msg)
    continue(state)
  end
end
