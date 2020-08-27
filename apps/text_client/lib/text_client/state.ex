defmodule TextClient.State do
  @moduledoc """
  This module defines the state struct used internally for this application
  """
  defstruct(
    game_service: nil,
    tally: nil,
    guess: ""
  )
end
