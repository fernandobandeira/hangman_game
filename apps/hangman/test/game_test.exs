defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    tally = Game.tally(game)

    assert tally.turns_left == game.turns_left
    assert tally.game_state == :initializing
    assert tally.used == []
    assert Enum.count(tally.letters) > 0
  end

  test "new_game with word returns structure" do
    game = Game.new_game("wibble")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    tally = Game.tally(game)

    assert tally.turns_left == game.turns_left
    assert tally.game_state == :initializing
    assert tally.used == []
    assert tally.letters == ["_", "_", "_", "_", "_", "_"]
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game =
        Game.new_game()
        |> Map.put(:game_state, state)

      assert {^game, _tally} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, tally} = Game.make_move(game, "w")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
    assert tally.turns_left == game.turns_left
    assert tally.game_state == :good_guess

    assert tally.used == ["w"]

    assert tally.letters == ["w", "_", "_", "_", "_", "_"]
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    {game, tally} = Game.make_move(game, "x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    assert tally.turns_left == game.turns_left
    assert tally.game_state == :bad_guess

    assert tally.used == ["x"]

    assert tally.letters == ["_", "_", "_", "_", "_", "_"]
  end

  test "lost is recognized" do
    moves = [
      {"a", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"f", :bad_guess},
      {"g", :bad_guess},
      {"h", :bad_guess},
      {"j", :lost}
    ]

    game = Game.new_game("wibble")

    moves
    |> Enum.with_index()
    |> Enum.reduce(game, fn {{guess, state}, index}, game ->
      {game, tally} = Game.make_move(game, guess)
      assert game.game_state == state
      assert game.turns_left == 7 - (index + 1)
      assert tally.turns_left == game.turns_left
      assert tally.game_state == state
      assert tally.used == Enum.to_list(game.used)
      assert tally.letters == ["_", "_", "_", "_", "_", "_"]
      game
    end)
  end
end
