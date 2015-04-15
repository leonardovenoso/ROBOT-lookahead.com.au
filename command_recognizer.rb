require 'pry'
require_relative 'modules/orientation'
require_relative 'modules/utils'

class CommandRecognizer
  include Orientation
  include Utils

  # Params:
  # - command_str: PLACE 0,0,NORTH / MOVE / LEFT / RIGHT / REPORT
  # Return:
  # - Hash type: { command: command[0], options: { direction: -2 } }
  def get_params(command_str)
    command = separate_in_tokens(command_str)
    return unknown_command_hash if command[0].nil?

    case command[0].downcase!
    when 'place'
      return place(command)
    when 'move', 'left', 'right', 'report', 'exit'
      return { command: command[0] }
    else
      return unknown_command_hash
    end
  end

  private

  def place(command)
    x = command[1]
    y = command[2]
    new_orientation = command[3].to_s + ' ' + command[4].to_s

    if integer?(x) && integer?(y) && orientation_valid?(new_orientation)
      return build_return_param(command[0], x, y, new_orientation)
    else
      return unknown_command_hash
    end
  end

  def build_return_param(command, x, y, new_orientation)
    { command: command,
      options: {
        x: x.to_i,
        y: y.to_i,
        orientation: string_to_symbol(new_orientation)
      }
    }
  end

  def unknown_command_hash
    { command: 'unknown' }
  end

  def orientation_valid?(new_orientation)
    orientation_symbol = string_to_symbol(new_orientation)
    orientation.key?(orientation_symbol) == true
  end

  def separate_in_tokens(commands)
    commands.upcase!
    commands.scan(/[(A-Za-z)|(!0-5)]*\w/)
  end
end
