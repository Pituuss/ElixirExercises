defmodule BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(ElixirExercises.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert ElixirExercises.Bucket.get(bucket, "milk") == nil

    ElixirExercises.Bucket.put(bucket, "milk", 3)
    assert ElixirExercises.Bucket.get(bucket, "milk") == 3
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(ElixirExercises.Bucket, []).restart == :temporary
  end
end
