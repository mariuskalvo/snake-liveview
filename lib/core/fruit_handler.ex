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

  @spec handle_consumed_fruit([Fruit.t()], SnakeBody.point(), Fruit.point(), boolean()) :: [Fruit.t()]
  def handle_consumed_fruit(fruits, snake_head, window_size, consumed) do
    case consumed do
      true  -> replace_consumed_fruit(fruits, snake_head, window_size)
      false -> fruits
    end
  end

  @spec replace_consumed_fruit([Fruit.t()], Fruit.point(), Fruit.point()) :: [Fruit.t()]
  def replace_consumed_fruit(fruits, snake_head, {width, height}) do
    fruits
    |> Enum.filter(fn %Fruit{location: location} -> location != snake_head end)
    |> (&([generate_fruit(width, height) | &1])).()
  end

  @spec maybe_add_Fruit([Fruit.t()], float(), Fruit.point()) :: [Fruit.t()]
  def maybe_add_Fruit(fruits, add_probability, {width, height}) do
    if :rand.uniform() < add_probability do
      [generate_fruit(width, height) | fruits]
    else
      fruits
    end
  end

end
