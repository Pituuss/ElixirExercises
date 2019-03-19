defmodule ElixirExericses.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    _ = start_supervised!({ElixirExercises.Registry, name: context.test})
    %{registry: context.test}
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
    _ = ElixirExercises.Registry.create(registry, "bogus")
    assert ElixirExercises.Registry.lookup(registry, "shopping") == :error
  end

  test "remove buckets on crash", %{registry: registry} do
    ElixirExercises.Registry.create(registry, "shopping")
    {:ok, bucket} = ElixirExercises.Registry.lookup(registry, "shopping")

    Agent.stop(bucket, :shutdown)
    _ = ElixirExercises.Registry.create(registry, "bogus")
    assert ElixirExercises.Registry.lookup(registry, "shopping") == :error
  end
end
