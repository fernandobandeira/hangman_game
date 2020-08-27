defmodule WordListTest do
  use ExUnit.Case

  test "dictionary can return a random word" do
    word = Dictionary.random_word()

    assert String.length(word) > 0
  end
end
