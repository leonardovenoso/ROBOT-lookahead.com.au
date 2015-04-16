require_relative 'modules/orientation'
require_relative 'print'
require_relative 'table'
require_relative 'modules/Utils'

class Base
  include Orientation
  include Utils

  ARRAY_SIZE_X = 5
  ARRAY_SIZE_Y = 5

  attr_accessor :current_position_x,
                :current_position_y,
                :current_orientation,
                :executed_valid_place_command,
                :table,
                :print

  def initialize
    @current_orientation  = ''
    @current_position_x   = 0
    @current_position_y   = 0
    @table = Table.new(5, 5)
    @executed_valid_place_command = false
    @print = Print.new
  end

  def was_executed_valid_place_command?
    @executed_valid_place_command
  end

  def print_board
    @print.board(@table.limit_x, @table.limit_y, @table.board)
  end

  def report
    puts "REPORT: (#{@current_position_x}, #{current_position_y}) #{@current_orientation}"
  end

  def unknown
    puts 'Unknown command...'
  end
end
