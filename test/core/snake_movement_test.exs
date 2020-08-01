defmodule Snake.Core.SnakeMovementTest do
  use ExUnit.Case
  alias Snake.Core.{SnakeBody, SnakeMovement}

  @snake_heading_left   %SnakeBody{body: [{1, 1}, {2, 1}, {3, 1}], head_direction: :left}
  @snake_heading_right  %SnakeBody{body: [{3, 1}, {2, 1}, {1, 1}], head_direction: :right}
  @snake_heading_up     %SnakeBody{body: [{1, 1}, {1, 2}, {1, 3}], head_direction: :up}
  @snake_heading_down   %SnakeBody{body: [{1, 3}, {1, 2}, {1, 1}], head_direction: :down}

  test "change direction to left with blocked by body is no-op" do
    expected = @snake_heading_right
    actual = SnakeMovement.change_direction(expected, :left)
    assert actual == expected
  end

  test "change direction to right with blocked by body is no-op" do
    expected = @snake_heading_left
    actual = SnakeMovement.change_direction(expected, :right)
    assert actual == expected
  end

  test "change direction to up with blocked by body is no-op" do
    expected = @snake_heading_down
    actual = SnakeMovement.change_direction(expected, :up)
    assert actual == expected
  end

  test "change direction to down with blocked by body is no-op" do
    expected = @snake_heading_up
    actual = SnakeMovement.change_direction(expected, :down)
    assert actual == expected
  end

  test "change direction to existing direction is no-op" do
    expected = @snake_heading_up
    actual = SnakeMovement.change_direction(expected, :up)
    assert actual == expected
  end

  test "change direction to up with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{head_direction: actual_direction} = SnakeMovement.change_direction(snake_body, :up)
    assert actual_direction == :up
  end

  test "change direction to down with snake heading right is successful" do
    snake_body = @snake_heading_right
    %SnakeBody{head_direction: actual_direction} = SnakeMovement.change_direction(snake_body, :down)
    assert actual_direction == :down
  end

  test "change direction to right with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{head_direction: actual_direction} = SnakeMovement.change_direction(snake_body, :right)
    assert actual_direction == :right
  end

  test "change direction to left with snake heading up is successful" do
    snake_body = @snake_heading_up
    %SnakeBody{head_direction: actual_direction} = SnakeMovement.change_direction(snake_body, :left)
    assert actual_direction == :left
  end

  test "move though wall at right side moves head to left side" do

    width = 20
    height = 20
    snake = %SnakeBody{
      head_direction: :right,
      body: [{width - 1, 1}]
    }

    %SnakeBody{body: [{new_x, _new_y}]} = SnakeMovement.move(snake, width, height)
    assert new_x == 0
  end

  test "move though wall at left side moves head to right side" do

    width = 20
    height = 20
    snake = %SnakeBody{
      head_direction: :left,
      body: [{0, 1}]
    }

    %SnakeBody{body: [{new_x, _new_y}]} = SnakeMovement.move(snake, width, height)
    assert new_x == width - 1
  end

  test "move though wall at upper side moves head to bottom side" do

    width = 20
    height = 20
    snake = %SnakeBody{
      head_direction: :up,
      body: [{0, 0}]
    }

    %SnakeBody{body: [{_new_x, new_y}]} = SnakeMovement.move(snake, width, height)
    assert new_y == height - 1
  end

  test "move though wall at bottom side moves head to upper side" do

    width = 20
    height = 20
    snake = %SnakeBody{
      head_direction: :down,
      body: [{0, height - 1}]
    }

    %SnakeBody{body: [{_new_x, new_y}]} = SnakeMovement.move(snake, width, height)
    assert new_y == 0
  end

end
