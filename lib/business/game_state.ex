defmodule Snake.Business.GameState do
  use Agent
  alias Snake.Business.SnakeBody
  @agent_name __MODULE__

  def start_link(_opts) do
    snake = %SnakeBody{
      head_direction: :down,
      body: [{0, 0}, {1, 0}, {2, 0}]
    }
    Agent.start_link(fn -> %{snake: snake} end, name: @agent_name)
  end

  def get_state() do
    Agent.get(@agent_name, fn state -> state end)
  end

  def update_state(key, value) do
    Agent.update(@agent_name, fn state -> Map.put(state, key, value) end)
  end
end
