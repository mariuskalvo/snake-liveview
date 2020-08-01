defmodule Snake.Core.SnakeBodyTest do
  use ExUnit.Case
  alias Snake.Core.SnakeBody

  test "new SnakeBody creates body of three elements" do
    %SnakeBody{body: body} = SnakeBody.new()
    assert length(body) == 3
  end
end
