defmodule SnakeWeb.SnakeLive do
  use SnakeWeb, :live_view
  import Phoenix.HTML, only: [raw: 1]
  alias Snake.Business.{SnakeBody, SnakeMovement}

  @square_size 20
  @squares_width 40
  @squares_height 22

  @impl true
  def mount(_params, _session, socket) do
    snake = %SnakeBody{
      body: [{2, 0}, {1, 0}, {0, 0}],
      head_direction: :right
    }

    :timer.send_interval(100, self(), :tick)
    {:ok, assign(socket, snake: snake)}
  end




  @impl true
  def handle_info(:tick, socket) do
    snake = socket.assigns.snake
    |> SnakeMovement.move()

    {:noreply, assign(socket, %{snake: snake})}
  end

  @impl true
  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket),   do: handle_direction_change(socket, :left)
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket),  do: handle_direction_change(socket, :right)
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket),     do: handle_direction_change(socket, :up)
  def handle_event("keydown", %{"key" => "ArrowDown"}, socket),   do: handle_direction_change(socket, :down)

  def handle_direction_change(socket, direction) do
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

    ~L"""
      <div phx-window-keydown="keydown">
        <h1>Snake live<h1>
        <%= raw svg_head() %>
        <%= raw body_rects %>
        <%= raw svg_foot() %>
      </div>
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
