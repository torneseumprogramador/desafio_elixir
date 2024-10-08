defmodule FogetesTest do
  use ExUnit.Case
  doctest Fogetes

  test "greets the world" do
    assert Fogetes.hello() == :world
  end
end
