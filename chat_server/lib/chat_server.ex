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
  use GenServer

  defmodule Message do
    defstruct content: "", username: "anon"
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :chat_room)
  end

  def get do
    GenServer.call(:chat_room, {:get})
  end

  def create(content) do
    GenServer.cast(:chat_room, {:create, content})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:create, msg}, from, state) do
    if is_map(msg) do
      new_state = state ++ [struct(Message, msg)]
      {:reply, new_state, new_state}
    else
      new_state = state ++ [%Message{content: msg}]
      {:reply, new_state, new_state}
    end
  end

  def handle_call({:get}, from, state) do
    {:reply, state, state}
  end

  def handle_cast({:create, msg}, state) do
    if is_map(msg) do
      new_state = state ++ [struct(Message, msg)]
      {:noreply, new_state}
    else
      new_state = state ++ [%Message{content: msg}]
      {:noreply, new_state}
    end
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
