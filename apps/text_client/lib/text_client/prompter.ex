defmodule TextClient.Prompter do
  @moduledoc """
  This module asks the user to enter his next guess
  """
  alias TextClient.State

  def accept_move(state = %State{}) do
    IO.gets("Your guess: ")
    |> check_input(state)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, _) do
    IO.puts("Looks like you gave up...")
    exit(:normal)
  end

  defp check_input(input, state) do
    input = String.trim(input)

    if input =~ ~r/\A[a-z]\z/ do
      Map.put(state, :guess, input)
    else
      IO.puts("please enter a single lowercase letter")
      accept_move(state)
    end
  end
end
