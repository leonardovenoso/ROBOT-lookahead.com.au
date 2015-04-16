class Table
  attr_reader :limit_x, :limit_y, :board

  def initialize(x, y)
    @limit_x = x
    @limit_y = y
    @board = Array.new(x) { Array.new(y, 0) }
  end
end