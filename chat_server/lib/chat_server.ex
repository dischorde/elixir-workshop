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

  def start_link(room_name) do
    GenServer.start_link(__MODULE__, :ok, name: via_tuple(room_name))
  end

  def get(room_name) do
    GenServer.call(via_tuple(room_name), {:get})
  end

  def create(room_name, content) do
    GenServer.cast(via_tuple(room_name), {:create, content})
  end

  def init(:ok) do
    {:ok, []}
  end

  def via_tuple(room_name) do
    {:via, Registry, {:chat_room, room_name}}
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

  def handle_call(request, from, state) do
    super(request, from, state)
  end

  def handle_cast(request, state) do
    super(request, state)
  end

  # def loop do
  #   loop([])
  # end
  #
  # defp loop(state) do
  #   receive do
  #     {:get, from} ->
  #       send(from, state)
  #       loop(state)
  #     {:create, msg} ->
  #       if is_map(msg) do
  #         formatted = struct(Message, msg)
  #         loop(state ++ [formatted])
  #       else
  #         formatted = %Message{content: msg}
  #         loop(state ++ [formatted])
  #       end
  #   end
  # end

end
