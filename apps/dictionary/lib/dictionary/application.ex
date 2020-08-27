defmodule Dictionary.Application do
  @moduledoc """
  This module starts a Dictionary application on its own separate process
  """
  use Application

  def start(_type, _args) do
    Dictionary.WordList.start_link()
  end
end
