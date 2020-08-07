defmodule SnakeWeb.SnakeLive do
  use SnakeWeb, :live_view
  alias Snake.Core.GameHandler

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      Map.merge(
        GameHandler.get_initial_state(),
        GameHandler.get_config()
      ))
    }
  end

  @impl true
  def handle_info(:tick, socket) do
    new_game_state = GameHandler.handle_tick(socket.assigns)
    {:noreply, assign(socket, new_game_state)}
  end

  @impl true
  def handle_event("restart_game", _value, socket) do
    {:noreply, assign(socket,
      Map.merge(
        GameHandler.get_initial_state(),
        GameHandler.get_config()
      ))
    }
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket),   do: handle_direction_change(socket, :left)
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket),  do: handle_direction_change(socket, :right)
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket),     do: handle_direction_change(socket, :up)
  def handle_event("keydown", %{"key" => "ArrowDown"}, socket),   do: handle_direction_change(socket, :down)
  def handle_event("keydown", %{"key" => " "}, socket) do
    %{game_over: game_over} = socket.assigns
    case game_over do
      true  -> handle_event("restart_game", nil, socket)
      false -> {:noreply, socket}
    end
  end
  def handle_event("keydown", _args, socket), do: {:noreply, socket}

  defp handle_direction_change(socket, direction) do
    snake = socket.assigns.snake
    |> GameHandler.change_direction(direction)
    {:noreply, assign(socket, %{snake: snake})}
  end
end
