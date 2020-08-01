defmodule Snake.Business.SnakeMovement do
  alias Snake.Business.SnakeBody

  @spec move(SnakeBody.t(), non_neg_integer(), non_neg_integer()) :: SnakeBody.t()
  def move(%SnakeBody{body: body, head_direction: direction}, squares_width, squares_height) do
    [{x, y} | _tail] = body

    new_head = case direction do
      :left   -> move_left(x, y, squares_width)
      :right  -> move_right(x, y, squares_width)
      :up     -> move_up(x, y, squares_height)
      :down   -> move_down(x, y, squares_height)
    end

    new_tail = Enum.take(body, length(body) - 1)

    %SnakeBody{
      body: [new_head] ++ new_tail,
      head_direction: direction
    }
  end

  defp move_down(x, y, height), do:   {x, rem(y + 1, height)}
  defp move_up(x, y, height) do
    if y <= 0, do: {x, height - 1}, else: {x, y - 1}
  end
  defp move_right(x, y, width), do:  {rem(x + 1, width), y}
  defp move_left(x, y, width) do
    if x <= 0, do: {width - 1, y}, else: {x - 1, y}
  end

  @spec change_direction(SnakeBody.t(), SnakeBody.direction()) :: SnakeBody.t()
  def change_direction(snake_body, direction) do
    noop_move = blocked_by_body?(snake_body, direction)

    case noop_move do
      true  -> snake_body
      false -> %SnakeBody{snake_body | head_direction: direction}
    end
  end

  defp blocked_by_body?(%SnakeBody{body: body}, direction) do
    [{head_x, head_y}, {second_x, second_y} | _tail] = body
    case direction do
      :left   -> head_x > second_x
      :right  -> head_x < second_x
      :up     -> head_y > second_y
      :down   -> head_y < second_y
    end
  end
end
