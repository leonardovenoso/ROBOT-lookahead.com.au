module Orientation
  def orientation
    { north: { x: -1 },
      north_east: { x: -1, y: 1 },
      east: { y: 1 },
      south_east: { x: 1, y: 1 },
      south: { x: 1 },
      south_west: { x: 1, y: -1 },
      west: { y: -1 },
      north_west: { x: 1, y: -1 }
    }
  end
end
