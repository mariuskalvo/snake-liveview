defmodule Snake.Core.FruitHandlerTest do
  use ExUnit.Case
  alias Snake.Core.{FruitHandler, Fruit}

  test "snake head at fruit location consumes fruit" do
    snake_head_location = {0, 0}
    fruit = %Fruit{
      location: {0, 0}
    }

    assert FruitHandler.consumed_fruit?(snake_head_location, [fruit])
  end
end
