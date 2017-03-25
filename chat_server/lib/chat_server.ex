defmodule ChatServer do
  @moduledoc """
  Documentation for ChatServer.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ChatServer.hello
      :world

  """
  def hello do
    :world
  end

  def loop do
    loop([])
  end

  defp loop(state) do
    receive do
      {:get, from} ->
        send(from, state)
        loop(state)
      {:create, msg} ->
        new_state = state ++ [msg]
        loop(new_state)
    end
  end
end
