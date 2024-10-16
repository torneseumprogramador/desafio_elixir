defmodule ConsoleAppTest do
  use ExUnit.Case
  doctest ConsoleApp

  test "greets the world" do
    assert ConsoleApp.hello() == :world
  end
end
