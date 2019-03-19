defmodule ElixirExercises.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {ElixirExercises.Registry, name: ElixirExercises.Registry},
      {DynamicSupervisor, name: ElixirExercises.BucketSupervisor, strategy: :one_for_one}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
