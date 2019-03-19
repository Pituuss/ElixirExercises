defmodule ElixirExercises do
  use Application

  def start(_type, _args) do
    ElixirExercises.Supervisor.start_link(name: ElixirExercises.Supervisor)
  end
end
