defmodule Snake.Business.SnakeBody do
  alias Snake.Business.SnakeBody

  defstruct [
    body: []
  ]

  @type point :: {integer(), integer()}
  @type t(body) :: %SnakeBody{body: body}
  @type t :: %SnakeBody{body: [point()]}

  @spec new :: SnakeBody.t()

  def new(), do: %SnakeBody{body: [{0, 0}, {0, 1}, {0, 2}]}
end
