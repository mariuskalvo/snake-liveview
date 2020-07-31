defmodule Snake.Business.GameLoopController do
  alias Snake.Business.{GameState, SnakeMovement, SnakeBody}

  @spec start :: {:error, any} | {:ok, :timer.tref()}
  def start() do
    GameState.start_link([])
    :timer.apply_interval(1000, __MODULE__, :tick, [])
  end

  @spec tick :: :ok
  def tick() do
    %{snake: snake} = GameState.get_state()
    updated_snake = SnakeMovement.move(snake)
    GameState.update_state(:snake, updated_snake)
  end

  @spec change_direction(SnakeBody.direction()) :: :ok
  def change_direction(direction) do
    %{snake: snake} = GameState.get_state()
    updated_snake = SnakeMovement.change_direction(snake, direction)
    GameState.update_state(:snake, updated_snake)
  end
end
