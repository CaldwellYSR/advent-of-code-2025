defmodule Vector2 do
  defstruct x: 0, y: 0

  def parse(line) do
    [x, y] = String.split(line, ",", trim: true)

    %Vector2{x: String.to_integer(x), y: String.to_integer(y)}
  end

  def get_area(%Vector2{} = a, %Vector2{} = b) do
    (abs(b.x - a.x) + 1) * (abs(b.y - a.y) + 1)
  end
end
