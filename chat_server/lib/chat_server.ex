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
  defmodule Message do
    defstruct content: "", username: "anon"
  end
  
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
        if is_map(msg) do
          formatted = struct(Message, msg)
          loop(state ++ [formatted])
        else
          formatted = %Message{content: msg}
          loop(state ++ [formatted])
        end
    end
  end


end
