defmodule SnakeWeb.SnakeLive do
  use SnakeWeb, :live_view
  import Phoenix.HTML, only: [raw: 1]
  alias Snake.Core.{SnakeBody, SnakeMovement, FruitHandler, Fruit, CollisionHandler}

  @square_size 20
  @squares_width 40
  @squares_height 22
  @timer_interval_ms 60
  @initial_snake_length 15

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, initial_state())}
  end

  defp initial_state() do
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

  @impl true
  def handle_info(:tick, socket) do
    %{
      fruits: fruits,
      snake: snake,
      points: points,
      timer_reference: timer_reference
    } = socket.assigns

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

    {:noreply, assign(socket, %{
      snake: moved_snake,
      fruits: updated_fruits,
      points: updated_points,
      game_over: is_game_over
    })}
  end

  @impl true
  def handle_event("restart_game", _value, socket) do
    {:noreply, assign(socket, initial_state())}
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket),   do: handle_direction_change(socket, :left)
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket),  do: handle_direction_change(socket, :right)
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket),     do: handle_direction_change(socket, :up)
  def handle_event("keydown", %{"key" => "ArrowDown"}, socket),   do: handle_direction_change(socket, :down)
  def handle_event("keydown", _args, socket), do: {:noreply, socket}

  defp handle_direction_change(socket, direction) do
    snake = socket.assigns.snake
    |> SnakeMovement.change_direction(direction)
    {:noreply, assign(socket, %{snake: snake})}
  end

  @impl true
  @spec render(atom | %{snake: atom | %{body: any}}) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do

    body_rects = assigns.snake.body
    |> Enum.map(fn {x, y} -> {x * @square_size, y * @square_size} end)
    |> Enum.map(fn {x, y} -> square(x, y) end)
    |> Enum.join("")

    fruit_shapes = assigns.fruits
    |> Enum.map(fn %Fruit{location: location} -> location end)
    |> Enum.map(fn {x, y} -> {x * @square_size, y * @square_size} end)
    |> Enum.map(fn {x, y} -> fruit_svg_body(x, y) end)
    |> Enum.join("")

    ~L"""
      <div phx-window-keydown="keydown">
        <h1>Points: <%= @points %><h1>
        <%= raw svg_head() %>
        <%= raw fruit_shapes %>

        <%= raw body_rects %>
        <%= raw svg_foot() %>

      </div>
      <%= if @game_over do %>
        <button phx-click="restart_game">
          GAME OVER - Try again
        </button>
      <% end %>
    """
  end


  defp fruit_svg_body(x, y) do
    """
    <rect
      x="#{x + 1}"" y="#{y + 1}"
      style="fill:red"
      height="#{@square_size - 2}"
      width="#{@square_size - 2}"
    />
    """
  end

  defp svg_head() do
    """
    <svg
      style="background: lightgray;"
      width="#{@square_size * @squares_width}px"
      height="#{@square_size * @squares_height}px"
    >
    """
  end

  defp square(x, y) do
    """
      <rect
        x="#{x + 1}"" y="#{y + 1}"
        style="fill:#444"
        height="#{@square_size - 2}"
        width="#{@square_size - 2}"
      />
    """
  end

  defp svg_foot() do
    """
      </svg>
    """
  end
end
