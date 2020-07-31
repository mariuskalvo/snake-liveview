defmodule Snake.Business.SnakeBodyTest do
  use ExUnit.Case
  alias Snake.Business.SnakeBody

  @snake_heading_left   %SnakeBody{body: [{1, 1}, {2, 1}, {3, 1}], head_direction: :left}
  @snake_heading_right  %SnakeBody{body: [{3, 1}, {2, 1}, {1, 1}], head_direction: :right}
  @snake_heading_up     %SnakeBody{body: [{1, 1}, {1, 2}, {1, 3}], head_direction: :up}
  @snake_heading_down   %SnakeBody{body: [{1, 3}, {1, 2}, {1, 1}], head_direction: :down}

  test "new SnakeBody creates body of three elements" do
    %SnakeBody{body: body} = SnakeBody.new()
    assert length(body) == 3
  end

  test "change direction to left with blocked by body is no-op" do
    expected = @snake_heading_right
    actual = SnakeBody.change_direction(expected, :left)
    assert actual == expected
  end

  test "change direction to right with blocked by body is no-op" do
    expected = @snake_heading_left
    actual = SnakeBody.change_direction(expected, :right)
    assert actual == expected
  end

  test "change direction to up with blocked by body is no-op" do
    expected = @snake_heading_down
    actual = SnakeBody.change_direction(expected, :up)
    assert actual == expected
  end

  test "change direction to down with blocked by body is no-op" do
    expected = @snake_heading_up
    actual = SnakeBody.change_direction(expected, :down)
    assert actual == expected
  end

  test "change direction to existing direction is no-op" do
    expected = @snake_heading_up
    actual = SnakeBody.change_direction(expected, :up)
    assert actual == expected
  end

  test "change direction to up with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{head_direction: actual_direction} = SnakeBody.change_direction(snake_body, :up)
    assert actual_direction == :up
  end

  test "change direction to down with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{head_direction: actual_direction} = SnakeBody.change_direction(snake_body, :down)
    assert actual_direction == :down
  end

  test "change direction to right with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{head_direction: actual_direction} = SnakeBody.change_direction(snake_body, :right)
    assert actual_direction == :right
  end

  test "change direction to left with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{head_direction: actual_direction} = SnakeBody.change_direction(snake_body, :left)
    assert actual_direction == :left
  end
end
