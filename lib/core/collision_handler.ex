defmodule Snake.Core.CollisionHandler do
  alias Snake.Core.SnakeBody

  @spec body_collision?(Snake.Core.SnakeBody.t()) :: boolean
  def body_collision?(%SnakeBody{body: body}) do
    [head | tail] = body
    Enum.any?(tail, &(&1 == head))
  end

end
