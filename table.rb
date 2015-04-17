class Table
  attr_reader :limit_x,
              :limit_y,
              :board,
              :lower_limit_x,
              :lower_limit_y

  def initialize(x, y)
    @limit_x = x
    @limit_y = y
    @lower_limit_x = 0
    @lower_limit_y = 0
    @board = Array.new(x) { Array.new(y, 0) }
  end
end
