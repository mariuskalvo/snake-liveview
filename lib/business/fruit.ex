defmodule Snake.Business.Fruit do
  alias Snake.Business.Fruit

  defstruct [
    location: {0, 0}
  ]

  @type point :: {integer(), integer()}
  @type t(location) :: %Fruit{location: location}
  @type t :: %Fruit{location: point()}

  @spec new :: Fruit.t()
  def new(), do: %Fruit{}

end
