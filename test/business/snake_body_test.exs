defmodule Snake.Business.SnakeBodyTest do
  use ExUnit.Case
  alias Snake.Business.SnakeBody

  @snake_heading_left   %SnakeBody{body: [{3, 1}, {2, 1}, {1, 1}], head_direction: :left}
  @snake_heading_right  %SnakeBody{body: [{1, 1}, {2, 1}, {3, 1}], head_direction: :right}
  @snake_heading_up     %SnakeBody{body: [{1, 1}, {1, 2}, {1, 3}], head_direction: :up}
  @snake_heading_down   %SnakeBody{body: [{1, 3}, {1, 2}, {1, 1}], head_direction: :down}

  test "new SnakeBody creates body of three elements" do
    %SnakeBody{body: body} = SnakeBody.new()
    assert length(body) == 3
  end

  test "move left with blocked by body is no-op" do
    expected = @snake_heading_right
    actual = SnakeBody.move(expected, :left)
    assert actual == expected
  end

  test "move right with blocked by body is no-op" do
    expected = @snake_heading_left
    actual = SnakeBody.move(expected, :right)
    assert actual == expected
  end

  test "move up with blocked by body is no-op" do
    expected = @snake_heading_down
    actual = SnakeBody.move(expected, :up)
    assert actual == expected
  end

  test "move down with blocked by body is no-op" do
    expected = @snake_heading_up
    actual = SnakeBody.move(expected, :down)
    assert actual == expected
  end

  test "move existing direction is no-op" do
    expected = @snake_heading_up
    actual = SnakeBody.move(expected, :up)
    assert actual == expected
  end

  test "move up with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{body: actual_body} = SnakeBody.move(snake_body, :up)
    expected_body = [{1, 0}, {1, 1}, {2, 1}]
    assert actual_body == expected_body
  end

  test "move down with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{body: actual_body} = SnakeBody.move(snake_body, :down)
    expected_body = [{1, 2}, {1, 1}, {2, 1}]

    assert actual_body == expected_body
  end

  test "move right with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{body: actual_body} = SnakeBody.move(snake_body, :right)
    expected_body = [{2, 1}, {1, 1}, {1, 2}]
    assert actual_body == expected_body
  end

  test "move left with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{body: actual_body} = SnakeBody.move(snake_body, :left)
    expected_body = [{0, 1}, {1, 1}, {1, 2}]
    assert actual_body == expected_body
  end
end
