require 'pry'
require_relative 'base'
require_relative 'command_recognizer'

class Robot < Base
  def initialize
    super
    @command_recognizer = CommandRecognizer.new
  end

  # Params:
  # - command_str: PLACE 0,0,NORTH / move / LEFT / right / REPORT
  def execute(command_str)
    command_hash = @command_recognizer.get_params(command_str)
    command = command_hash[:command]
    options = command_hash[:options]

    if options.nil?
      send(command)
    else
      send(command, options)
    end
  end

  private

  def left
    rotate(-2)
  end

  def right
    rotate(2)
  end

  def exit
    Kernel.exit!
  end

  # Params:
  # - direction: -2 or 2
  def rotate(direction)
    return unless was_executed_valid_place_command?

    orientation_keys = orientation.keys
    orientation_index = orientation_keys.index(@current_orientation) + direction
    @current_orientation = orientation_keys[orientation_index].nil? ? orientation_keys[0] : orientation_keys[orientation_index]
    @table.board[@current_position_x][@current_position_y] = abbreviate(@current_orientation)

    print_board
  end

  def move
    return unless was_executed_valid_place_command?

    x = next_x_to_move
    y = next_y_to_move

    place(x: x, y: y)
  end

  # PARAMS:
  # - options: {x: 1, y: 1, orientation: :NORTH}
  def place(options)
    x, y = options[:x], options[:y]
    @current_orientation = options[:orientation] unless options[:orientation].nil?

    if x < @table.limit_x && x >= @table.lower_limit_x && y < @table.limit_y && y >= @table.lower_limit_y
      set_current_position(x, y)
      @executed_valid_place_command = true
      print_board
      true
    else
      false
    end
  end

  def set_current_position(x, y)
    @table.board[@current_position_x][@current_position_y] = 0

    @current_position_x = x
    @current_position_y = y

    abbreviation = abbreviate(@current_orientation)
    @table.board[x][y] = abbreviation.empty? ? 'x' : abbreviation
  end

  def next_x_to_move
    orientation[@current_orientation][:x].nil? ? @current_position_x : @current_position_x + orientation[@current_orientation][:x]
  end

  def next_y_to_move
    orientation[@current_orientation][:y].nil? ? @current_position_y : @current_position_y + orientation[@current_orientation][:y]
  end
end
