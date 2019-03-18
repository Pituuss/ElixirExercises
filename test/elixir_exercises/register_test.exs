defmodule ElixirExericses.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(ElixirExercises.Registry)
    %{registry: registry}
  end

  test "spawn buckets", %{registry: registry} do
    assert ElixirExercises.Registry.lookup(registry, "shopping") == :error

    ElixirExercises.Registry.create(registry, "shopping")
    assert {:ok, bucket} = ElixirExercises.Registry.lookup(registry, "shopping")

    ElixirExercises.Bucket.put(bucket, "milk", 1)
    assert ElixirExercises.Bucket.get(bucket, "milk") == 1
  end

  test "remove buckets on exit", %{registry: registry} do
    ElixirExercises.Registry.create(registry, "shopping")
    {:ok, bucket} = ElixirExercises.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert ElixirExercises.Registry.lookup(registry, "shopping") == :error
  end
end
