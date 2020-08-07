defmodule Snake.Core.CollisionHandlerTest do
  use ExUnit.Case
  alias Snake.Core.{SnakeBody, CollisionHandler}

  test "Head at any of the tail section position causes collision" do
    snake_body = %SnakeBody{body: [{0, 0}, {0, 1}, {0, 2}, {0, 0}]}
    assert CollisionHandler.body_collision?(snake_body)
  end

  test "Head not in any of the tail section position does not cause collision" do
    snake_body = %SnakeBody{body: [{0, 0}, {0, 1}, {0, 2}, {0, 3}]}
    assert !CollisionHandler.body_collision?(snake_body)
  end
end
