defmodule Snake.Business.SnakeBody do
  alias Snake.Business.SnakeBody

  defstruct [
    body: [],
    head_direction: :down
  ]

  @type direction :: :left | :right | :up | :down
  @type point :: {integer(), integer()}

  @type t(body, head_direction) :: %__MODULE__{
    body: body,
    head_direction: head_direction
  }

  @type t :: %__MODULE__{
    body: [point()],
    head_direction: direction()
  }

  @spec new :: SnakeBody.t()
  def new(), do: %SnakeBody{body: [{0, 0}, {0, 1}, {0, 2}]}
end
