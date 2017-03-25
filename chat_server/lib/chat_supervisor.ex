defmodule ChatServer.Supervisor do
  # allows this module to use all of the Supervisor module's functions
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: :chat_supervisor)
  end

  def init(:ok) do
    # the child processes of this supervisor are one ChatServer
      # the second argument is a list of arguments that should get passed to
      # that module's start_link function
    children = [
      worker(ChatServer, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
