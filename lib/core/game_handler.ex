defmodule Snake.Core.GameHandler do
  alias Snake.Core.{SnakeBody, SnakeMovement, FruitHandler, Fruit, CollisionHandler}

  @square_size 20
  @squares_width 40
  @squares_height 22
  @timer_interval_ms 60
  @initial_snake_length 15

  def get_initial_state() do
    initial_fruit = FruitHandler.generate_fruit(
      @squares_width,
      @squares_height
    )

    body = (@initial_snake_length - 1)..0
    |> Enum.map(&{&1, 0})

    snake = %SnakeBody{
      body: body,
      head_direction: :right
    }

    timer_reference = case :timer.send_interval(@timer_interval_ms, self(), :tick) do
      {:ok, timer_ref} -> timer_ref
      {:error, reason} -> raise "Could not start game loop: #{reason}"
    end

    %{
      snake: snake,
      fruits: [initial_fruit],
      points: 0,
      game_over: false,
      timer_reference: timer_reference
    }
  end

  def handle_tick(game_state) do
    %{
      fruits: fruits,
      snake: snake,
      points: points,
      timer_reference: timer_reference
    } = game_state

    %SnakeBody{body: [snake_head | _tail]} = snake

    consumed_fruit = FruitHandler.consumed_fruit?(snake_head, fruits)

    moved_snake = SnakeMovement.move(
      snake,
      @squares_width,
      @squares_height,
      consumed_fruit
    )

    is_game_over = CollisionHandler.body_collision?(moved_snake)
    if is_game_over do
      :timer.cancel(timer_reference)
    end

    updated_points = case consumed_fruit do
      true ->  points + 1
      false -> points
    end

    updated_fruits = case consumed_fruit do
      true  ->
        filtered_fruits = fruits
        |> Enum.filter(fn %Fruit{location: location} -> location != snake_head end)
        [FruitHandler.generate_fruit(@squares_width, @squares_height) | filtered_fruits]
      false -> fruits
    end

    %{
      snake: moved_snake,
      fruits: updated_fruits,
      points: updated_points,
      game_over: is_game_over
    }
  end

  @spec change_direction(SnakeBody.t(), SnakeBody.direction()) :: SnakeBody.t()
  def change_direction(snake, direction) do
    SnakeMovement.change_direction(snake, direction)
  end

  def get_config() do
    %{
      square_size: @square_size,
      squares_width: @squares_width,
      squares_height: @squares_height,
      timer_interval_ms: @timer_interval_ms,
      initial_snake_length: @initial_snake_length,
    }
  end

end