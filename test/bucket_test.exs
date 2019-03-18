defmodule BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = ElixirExercises.Bucket.start_link([])
  end

  test "stores values by key", %{bucket: bucket} do
    assert ElixirExercises.Bucket.get(bucket, "milk") == nil

    ElixirExercises.Bucket.put(bucket, "milk", 3)
    assert ElixirExercises.Bucket.get(bucket, "milk") == 3
  end
end
