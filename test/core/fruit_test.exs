defmodule Snake.Core.FruitTest do
  use ExUnit.Case
  alias Snake.Core.Fruit

  test "new Fruit creates fruit with 0,0 location" do
    %Fruit{location: location} = Fruit.new()
    assert location == {0, 0}
  end
end
