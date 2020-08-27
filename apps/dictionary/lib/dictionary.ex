defmodule Dictionary do
  @moduledoc """
  This module provides a public API for the words dictionary used in the game
  """
  alias Dictionary.WordList

  defdelegate random_word(word_list), to: WordList
  defdelegate start(), to: WordList, as: :word_list
end
