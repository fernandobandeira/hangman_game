defmodule GallowsWeb.Views.Helpers.GameStateHelper do

  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won => {:info, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:info, "Good Guess!"},
    :bad_guess => {:warning, "Bad Guess!"},
    :already_used => {:warning, "You already guessed that"}
  }

  def game_state(:initializing), do: ""
  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert({class, message}) do
    """
      <div class="alert alert-#{class}">
        #{message}
      </div>
    """
    |> raw()
  end
end
