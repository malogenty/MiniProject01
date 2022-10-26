defmodule Miniproject01Test do
  use ExUnit.Case
  doctest Miniproject01

  test "greets the world" do
    assert Miniproject01.hello() == :world
  end
end
