defmodule Snake.Business.SnakeBody do
  alias Snake.Business.SnakeBody

  defstruct [
    body: [],
    head_direction: :down
  ]

  @type direction :: :left | :right | :up | :down
  @type point :: {integer(), integer()}

  @type t(body, head_direction) :: %SnakeBody{body: body, head_direction: head_direction}
  @type t :: %SnakeBody{body: [point()], head_direction: direction()}

  @spec new :: SnakeBody.t()
  def new(), do: %SnakeBody{body: [{0, 0}, {0, 1}, {0, 2}]}

  @spec move(SnakeBody.t()) :: SnakeBody.t()
  def move(%SnakeBody{body: body, head_direction: direction}) do
    [{x, y} | _tail] = body

    new_head = case direction do
      :left   -> {x - 1, y}
      :right  -> {x + 1, y}
      :up     -> {x, y - 1}
      :down   -> {x, y + 1}
    end

    new_tail = Enum.take(body, length(body) - 1)

    %SnakeBody{
      body: [new_head] ++ new_tail,
      head_direction: direction
    }
  end

  @spec change_direction(Snake.Business.SnakeBody.t(), direction()) :: Snake.Business.SnakeBody.t()
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
