defmodule Snake.Core.FruitHandler do
  alias Snake.Core.{Fruit, SnakeBody}

  @spec generate_fruit(pos_integer, pos_integer) :: Snake.Core.Fruit.t()
  def generate_fruit(squares_width, squares_height) do
    x_location = :rand.uniform(squares_width) - 1
    y_location = :rand.uniform(squares_height) - 1
    %Fruit{location: {x_location, y_location}}
  end

  @spec consumed_fruit?(SnakeBody.point(), [Fruit.t()]) :: boolean()
  def consumed_fruit?(snake_head_location, fruits) do
    Enum.any?(fruits, fn %Fruit{location: location} ->
      snake_head_location == location
    end)
  end

end
