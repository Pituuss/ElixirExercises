defmodule ElixirExercisesTest do
  use ExUnit.Case
  doctest ElixirExercises

  test "greets the world" do
    assert ElixirExercises.hello() == :oops
  end
end
